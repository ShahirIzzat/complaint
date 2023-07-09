import 'package:flutter/material.dart';

import 'package:complaint/login.dart';
import 'package:complaint/complaint.dart';
import 'package:complaint/list.dart';
import 'package:complaint/test.dart';
import 'package:complaint/home.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Complaint Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}
