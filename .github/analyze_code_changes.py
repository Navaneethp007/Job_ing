#!/usr/bin/env python3
"""
Code Analyzer Script for GitHub Action

This script analyzes code changes in a repository:
- Detects changes between commits in a push
- Identifies changed/added/deleted functions, classes, and methods
- Generates structured JSON output for further processing by LLM backend
"""

import os
import sys
import json
import hashlib
import tempfile
from pathlib import Path
from typing import Dict, List, Set, Tuple, Any, Optional
from git import Repo, GitCommandError
from tree_sitter import Language, Parser
import argparse

# Configure paths
REPO_PATH = os.getcwd()
DOCAI_DIR = os.path.join(REPO_PATH, ".docai")
ELEMENTS_DB_PATH = os.path.join(DOCAI_DIR, "code_elements.json")

# Ensure .docai directory exists
os.makedirs(DOCAI_DIR, exist_ok=True)

# Language extensions mapping
LANGUAGE_EXTENSIONS = {
    ".py": "python",
    ".js": "javascript",
    ".jsx": "javascript",
    ".ts": "typescript",
    ".tsx": "tsx",
    ".java": "java",
    ".go": "go",
    ".rs": "rust",
}

# Tree-sitter language modules mapping
try:
    import tree_sitter_python
    import tree_sitter_javascript
    import tree_sitter_typescript
    import tree_sitter_java
    import tree_sitter_go
    import tree_sitter_rust

    LANGUAGE_MODULES = {
        "python": tree_sitter_python.language,
        "javascript": tree_sitter_javascript.language,
        "typescript": tree_sitter_typescript.language_typescript,
        "tsx": tree_sitter_typescript.language_tsx,
        "java": tree_sitter_java.language,
        "go": tree_sitter_go.language,
        "rust": tree_sitter_rust.language,
    }
except ImportError:
    print("Warning: Some tree-sitter language modules could not be imported")
    LANGUAGE_MODULES = {}


class CodeAnalyzer:
    """Analyzes code changes in a git repository."""

    def __init__(self, repo_path: str):
        """
        Initialize the CodeAnalyzer.

        Args:
            repo_path: Path to the git repository
        """
        self.repo_path = repo_path
        self.repo = Repo(repo_path)
        self.languages = self._setup_tree_sitter()
        self.parser = Parser()
        self.code_elements_db = self._load_code_elements_db()
        self._custom_commit_range = None

    def _setup_tree_sitter(self) -> Dict[str, Language]:
        """Initialize and load tree-sitter languages."""
        lang_objects = {}
        for lang_name, lang_module in LANGUAGE_MODULES.items():
            try:
                if lang_module():
                    lang_objects[lang_name] = Language(lang_module())
            except Exception as e:
                print(f"Error loading language {lang_name}: {e}")
        return lang_objects

    def _load_code_elements_db(self) -> Dict:
        """Load existing code elements database if it exists."""
        if os.path.exists(ELEMENTS_DB_PATH):
            try:
                with open(ELEMENTS_DB_PATH, "r", encoding="utf-8") as f:
                    return json.load(f)
            except json.JSONDecodeError:
                print(
                    f"Warning: Invalid JSON in {ELEMENTS_DB_PATH}, creating new database"
                )

        # Return empty database structure if file doesn't exist or is invalid
        return {"elements": {}, "metadata": {"last_processed_commit": None}}

    def _save_code_elements_db(self):
        """Save the code elements database."""
        with open(ELEMENTS_DB_PATH, "w", encoding="utf-8") as f:
            json.dump(self.code_elements_db, f, indent=2)

    def _get_file_language(self, file_path: str) -> Optional[str]:
        """
        Determine the programming language of a file based on its extension.

        Args:
            file_path: Path to the file

        Returns:
            Language name or None if not supported
        """
        extension = os.path.splitext(file_path)[1].lower()
        return LANGUAGE_EXTENSIONS.get(extension)

    def _get_push_commits(self) -> Tuple[str, str]:
        """
        Get the commit range for the current push.

        For GitHub Actions, determines the before and after commits of the push.
        Can be overridden by command-line arguments.

        Returns:
            Tuple of (before_commit, after_commit)
        """
        # If custom commit range is provided, use it
        if self._custom_commit_range:
            return self._custom_commit_range

        # In GitHub Actions environment
        if os.environ.get("GITHUB_EVENT_NAME") == "push":
            # If this is a push event, get the before and after SHAs
            try:
                # Try to get the before and after commits from the GitHub context
                event_path = os.environ.get("GITHUB_EVENT_PATH")
                if event_path and os.path.exists(event_path):
                    with open(event_path, "r") as f:
                        event_data = json.load(f)
                        before_commit = event_data.get("before")
                        after_commit = event_data.get("after")
                        if before_commit and after_commit:
                            return before_commit, after_commit
            except Exception as e:
                print(f"Error reading GitHub event data: {e}")

        # Get the first commit in the repository as the "before" commit
        try:
            # Get the first commit
            first_commit = None
            for commit in self.repo.iter_commits("--all", max_parents=0):
                first_commit = commit.hexsha
                break  # Just need the first one

            if not first_commit:
                # Empty repository case - use git's empty tree object
                first_commit = self.repo.git.hash_object("-t", "tree", "/dev/null")

            # Use HEAD as the "after" commit
            last_commit = self.repo.head.commit.hexsha

            return first_commit, last_commit
        except Exception as e:
            print(f"Error determining commit range: {e}")
            # If all else fails, dynamically create an empty tree object
            empty_tree = self.repo.git.hash_object("-t", "tree", "/dev/null")
            return empty_tree, "HEAD"

    def _get_affected_files(
        self, before_commit: str, after_commit: str
    ) -> Dict[str, List[str]]:
        """
        Get files affected (modified, added, deleted) between two commits.

        Args:
            before_commit: Starting commit hash
            after_commit: Ending commit hash

        Returns:
            Dictionary with lists of modified, added, and deleted files
        """
        result = {"modified": [], "added": [], "deleted": []}

        # Handle first commit case - check if before_commit is an empty tree
        try:
            # Try to get the commit - will fail if it's an empty tree
            self.repo.commit(before_commit)
        except Exception:
            # Likely an empty tree - all files are new
            diff_index = self.repo.git.diff(
                "--name-status", before_commit, after_commit
            )
            for line in diff_index.splitlines():
                parts = line.split("\t")
                if len(parts) >= 2:
                    status, filename = parts[0], parts[1]
                    if status == "A":
                        file_path = os.path.join(self.repo_path, filename)
                        result["added"].append(file_path)
            return result

        # Get diff between commits
        diff_index = self.repo.git.diff("--name-status", before_commit, after_commit)

        for line in diff_index.splitlines():
            parts = line.split("\t")
            if len(parts) >= 2:
                status, filename = parts[0], parts[1]
                file_path = os.path.join(self.repo_path, filename)

                if status == "M":
                    result["modified"].append(file_path)
                elif status == "A":
                    result["added"].append(file_path)
                elif status == "D":
                    result["deleted"].append(file_path)
                elif status.startswith("R"):
                    # Handle renamed files (old name is deleted, new name is added)
                    if len(parts) >= 3:
                        old_filename, new_filename = parts[1], parts[2]
                        old_path = os.path.join(self.repo_path, old_filename)
                        new_path = os.path.join(self.repo_path, new_filename)
                        result["deleted"].append(old_path)
                        result["added"].append(new_path)

        return result

    def _get_affected_lines(
        self, file_path: str, before_commit: str, after_commit: str
    ) -> Set[int]:
        """
        Get line numbers affected by changes between two commits for a specific file.

        Args:
            file_path: Path to the file
            before_commit: Starting commit hash
            after_commit: Ending commit hash

        Returns:
            Set of affected line numbers
        """
        rel_path = os.path.relpath(file_path, self.repo_path)
        affected_lines = set()

        try:
            # Get unified diff with context
            diff_output = self.repo.git.diff(
                before_commit, after_commit, rel_path, unified=0
            )

            for line in diff_output.splitlines():
                if line.startswith("@@"):
                    # Parse the @@ -a,b +c,d @@ line
                    parts = line.split()
                    if len(parts) >= 2:
                        line_info = parts[1]  # +c,d part
                        if line_info.startswith("+"):
                            line_info = line_info[1:]  # Remove the + sign
                            if "," in line_info:
                                start_line, num_lines = map(int, line_info.split(","))
                            else:
                                start_line, num_lines = int(line_info), 1

                            # Add all affected lines to the set
                            affected_lines.update(
                                range(start_line, start_line + num_lines)
                            )
        except GitCommandError:
            # File might be new or deleted, consider all lines affected
            return set(range(1, 100000))
        except Exception as e:
            print(f"Error getting affected lines for {file_path}: {e}")
            return set(range(1, 100000))

        return affected_lines

    def _get_file_content_at_commit(
        self, file_path: str, commit: str
    ) -> Optional[bytes]:
        """
        Get the content of a file at a specific commit.

        Args:
            file_path: Path to the file
            commit: Commit hash

        Returns:
            File content as bytes or None if not found
        """
        rel_path = os.path.relpath(file_path, self.repo_path)

        try:
            # Get the file content at the specific commit
            content = self.repo.git.show(f"{commit}:{rel_path}")
            return content.encode("utf-8", errors="replace")
        except GitCommandError:
            # File might not exist at this commit
            return None
        except Exception as e:
            print(f"Error getting file content for {file_path} at {commit}: {e}")
            return None

    def _parse_file(
        self, file_path: str, content: Optional[bytes] = None
    ) -> List[Dict]:
        """
        Parse a file to extract code elements (functions, classes, methods).

        Args:
            file_path: Path to the file
            content: Optional file content (bytes), reads from file if None

        Returns:
            List of code elements
        """
        lang_name = self._get_file_language(file_path)
        if not lang_name or lang_name not in self.languages:
            return []

        # Get file content if not provided
        if content is None:
            try:
                with open(file_path, "rb") as f:
                    content = f.read()
            except Exception as e:
                print(f"Error reading file {file_path}: {e}")
                return []

        # Define queries for different languages
        queries = {
            "python": """
                (function_definition
                  name: (identifier) @function_name) @function

                (class_definition
                  name: (identifier) @class_name) @class
            """,
            "javascript": """
                (function_declaration
                  name: (identifier) @function_name) @function

                (class_declaration
                  name: (identifier) @class_name) @class

                (method_definition
                  name: (property_identifier) @method_name) @method

                (arrow_function
                  parameters: (formal_parameters) @params) @arrow_function
            """,
            "typescript": """
                (function_declaration
                  name: (identifier) @function_name) @function

                (class_declaration
                  name: (type_identifier) @class_name) @class

                (method_definition
                  name: (property_identifier) @method_name) @method
            """,
            "java": """
                (method_declaration
                  name: (identifier) @method_name) @method

                (class_declaration
                  name: (identifier) @class_name) @class
            """,
            "go": """
                (function_declaration
                  name: (identifier) @function_name) @function

                (method_declaration
                  name: (field_identifier) @method_name) @method
            """,
            "rust": """
                (function_item
                  name: (identifier) @function_name) @function

                (impl_item
                  name: (identifier) @impl_name) @impl
            """,
        }

        if lang_name not in queries:
            return []

        # Parse the file
        self.parser.language = self.languages[lang_name]
        tree = self.parser.parse(content)

        print(f"Parsing file: {file_path}")

        # Try direct approach using the node iterator
        code_elements = []

        # Find function definitions
        for node in self._iter_tree(tree.root_node):
            element_type = None
            element_name = None

            # Check node type to determine element type
            if node.type == "function_definition":
                element_type = "function"
            elif node.type == "class_definition":
                element_type = "class"
            elif node.type == "method_definition":
                element_type = "method"
            elif node.type == "function_declaration":
                element_type = "function"
            elif node.type == "class_declaration":
                element_type = "class"

            if element_type:
                # Find the name node
                for child in node.children:
                    if (
                        child.type == "identifier"
                        or child.type == "property_identifier"
                    ):
                        element_name = content[
                            child.start_byte : child.end_byte
                        ].decode("utf-8", errors="replace")
                        break

                if element_name:
                    # Get the full code
                    element_code = content[node.start_byte : node.end_byte].decode(
                        "utf-8", errors="replace"
                    )

                    # Use relative path for file_path
                    rel_file_path = os.path.relpath(file_path, self.repo_path)

                    # Create the element
                    code_elements.append(
                        {
                            "type": element_type,
                            "name": element_name,
                            "start_line": node.start_point[0]
                            + 1,  # 1-based line numbering
                            "end_line": node.end_point[0] + 1,
                            "code": element_code,
                            "file_path": rel_file_path,
                        }
                    )
                    print(f"Found {element_type}: {element_name}")

        return code_elements

    def _iter_tree(self, node):
        """Helper method to iterate through all nodes in a tree."""
        yield node
        for child in node.children:
            yield from self._iter_tree(child)

    def _parse_file_at_commit(self, file_path: str, commit: str) -> List[Dict]:
        """
        Parse a file at a specific commit to extract code elements.

        Args:
            file_path: Path to the file
            commit: Commit hash

        Returns:
            List of code elements
        """
        content = self._get_file_content_at_commit(file_path, commit)
        if not content:
            return []

        return self._parse_file(file_path, content)

    def _generate_element_id(self, element: Dict) -> str:
        """
        Generate a unique ID for a code element.

        Args:
            element: Code element dictionary

        Returns:
            Unique ID string
        """
        rel_path = os.path.relpath(element['file_path'], self.repo_path)
        unique_str = f"{rel_path}:{element['name']}:{element['type']}"
        return hashlib.md5(unique_str.encode()).hexdigest()

    def analyze_repo_changes(self) -> Dict:
        """
        Analyze changes in the repository.

        Returns:
            Dictionary with added, modified, and deleted code elements
        """
        before_commit, after_commit = self._get_push_commits()
        print(f"Analyzing changes between {before_commit} and {after_commit}")

        # Get affected files
        affected_files = self._get_affected_files(before_commit, after_commit)

        # Lists to track code elements
        added_elements = []
        modified_elements = []
        deleted_elements = []

        # Process modified files
        for file_path in affected_files["modified"]:
            lang_name = self._get_file_language(file_path)
            if not lang_name or lang_name not in self.languages:
                continue

            # Get affected lines
            affected_lines = self._get_affected_lines(
                file_path, before_commit, after_commit
            )

            # Get elements from before commit
            before_elements = self._parse_file_at_commit(file_path, before_commit)
            before_elements_map = {
                self._generate_element_id(e): e for e in before_elements
            }

            # Get elements from after commit
            after_elements = self._parse_file(file_path)
            after_elements_map = {
                self._generate_element_id(e): e for e in after_elements
            }

            # Find added and modified elements
            for element_id, after_element in after_elements_map.items():
                # Always consider the element affected for now
                # This is a simplification to ensure elements are captured
                is_affected = True

                if element_id in before_elements_map:
                    # Element exists in both commits - check if modified
                    before_element = before_elements_map[element_id]

                    # Only add if the code has actually changed
                    if before_element["code"] != after_element["code"]:
                        modified_elements.append(after_element)

                        # Update the elements database
                        self.code_elements_db["elements"][element_id] = {
                            "type": after_element["type"],
                            "name": after_element["name"],
                            "file_path": after_element["file_path"],
                            "code": after_element["code"],
                            "last_modified": after_commit,
                        }
                        print(
                            f"Modified element: {after_element['type']} {after_element['name']}"
                        )
                else:
                    # Element exists only in after commit - added
                    added_elements.append(after_element)

                    # Add to the elements database
                    self.code_elements_db["elements"][element_id] = {
                        "type": after_element["type"],
                        "name": after_element["name"],
                        "file_path": after_element["file_path"],
                        "code": after_element["code"],
                        "added_at": after_commit,
                    }
                    print(
                        f"Added element: {after_element['type']} {after_element['name']}"
                    )

            # Find deleted elements
            for element_id, before_element in before_elements_map.items():
                if element_id not in after_elements_map:
                    deleted_elements.append(before_element)

                    # Mark as deleted in the database if it exists
                    if element_id in self.code_elements_db["elements"]:
                        self.code_elements_db["elements"][element_id][
                            "deleted_at"
                        ] = after_commit
                    print(
                        f"Deleted element: {before_element['type']} {before_element['name']}"
                    )

        # Process added files
        for file_path in affected_files["added"]:
            lang_name = self._get_file_language(file_path)
            if not lang_name or lang_name not in self.languages:
                continue

            # Get elements from the new file
            elements = self._parse_file(file_path)

            for element in elements:
                element_id = self._generate_element_id(element)
                added_elements.append(element)

                # Add to the elements database
                self.code_elements_db["elements"][element_id] = {
                    "type": element["type"],
                    "name": element["name"],
                    "file_path": element["file_path"],
                    "code": element["code"],
                    "added_at": after_commit,
                }
                print(
                    f"Added element from new file: {element['type']} {element['name']}"
                )

        # Process deleted files
        for file_path in affected_files["deleted"]:
            lang_name = self._get_file_language(file_path)
            if not lang_name or lang_name not in self.languages:
                continue

            # Get elements from the deleted file in the previous commit
            elements = self._parse_file_at_commit(file_path, before_commit)

            for element in elements:
                element_id = self._generate_element_id(element)
                deleted_elements.append(element)

                # Mark as deleted in the database if it exists
                if element_id in self.code_elements_db["elements"]:
                    self.code_elements_db["elements"][element_id][
                        "deleted_at"
                    ] = after_commit
                print(
                    f"Deleted element from removed file: {element['type']} {element['name']}"
                )

        # Update metadata
        self.code_elements_db["metadata"]["last_processed_commit"] = after_commit

        # Save the updated database
        self._save_code_elements_db()

        # Generate report JSON
        report = {
            "affected_elements": {
                "added": added_elements,
                "modified": modified_elements,
                "deleted": deleted_elements,
            },
            "stats": {
                "added": len(added_elements),
                "modified": len(modified_elements),
                "deleted": len(deleted_elements),
                "total_elements": len(self.code_elements_db["elements"]),
            },
            "metadata": {
                "repository": os.path.basename(self.repo_path),
                "commit_range": {"before": before_commit, "after": after_commit},
                "timestamp": self.repo.head.commit.committed_datetime.isoformat(),
            },
        }

        # Save the report
        report_path = os.path.join(DOCAI_DIR, f"change_report_{after_commit[:7]}.json")
        with open(report_path, "w", encoding="utf-8") as f:
            json.dump(report, f, indent=2)

        print(f"Report saved to {report_path}")
        print(
            f"Added: {len(added_elements)}, Modified: {len(modified_elements)}, Deleted: {len(deleted_elements)}"
        )

        return report


def main():
    try:
        # Set up argument parser
        parser = argparse.ArgumentParser(
            description="Analyze code changes between commits"
        )
        parser.add_argument(
            "--before", help="Starting commit hash (defaults to first commit in repo)"
        )
        parser.add_argument("--after", help="Ending commit hash (defaults to HEAD)")
        args = parser.parse_args()

        print("Starting code analysis...")
        analyzer = CodeAnalyzer(REPO_PATH)

        # If commit hashes are provided via command line, use them
        if args.before is not None or args.after is not None:
            repo = Repo(REPO_PATH)

            # Handle before commit
            if args.before is None:
                # If before is not provided, use the first commit in the repository
                try:
                    # Find commits with no parents (root commits)
                    first_commit = None
                    for commit in repo.iter_commits("--all", max_parents=0):
                        first_commit = commit.hexsha
                        break  # Just need the first one

                    if first_commit:
                        before_commit = first_commit
                        print(f"Using first commit as before: {before_commit}")
                    else:
                        # Empty repository case - use git's empty tree object
                        before_commit = repo.git.hash_object("-t", "tree", "/dev/null")
                except Exception as e:
                    print(f"Error finding first commit: {e}")
                    before_commit = repo.git.hash_object("-t", "tree", "/dev/null")
            else:
                before_commit = args.before

            # Handle after commit
            if args.after is None:
                after_commit = "HEAD"
            else:
                after_commit = args.after

            # Override the commit range
            analyzer._custom_commit_range = (before_commit, after_commit)

        analyzer.analyze_repo_changes()
        print("Code analysis completed successfully")
    except Exception as e:
        print(f"Error: {e}")
        import traceback

        traceback.print_exc()
        sys.exit(1)


if __name__ == "__main__":
    main()
