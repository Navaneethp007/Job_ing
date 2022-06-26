import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_bing/choose.dart';
import 'package:job_bing/emp.dart';
import 'package:job_bing/emplogin.dart';
import 'package:job_bing/recruit.dart';
import 'package:job_bing/recruitsign.dart';
import 'package:job_bing/recruitlog.dart';
import 'package:job_bing/forgot.dart';
import 'package:job_bing/profile.dart';


void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
      
      home:Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
