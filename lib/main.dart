import 'package:flutter/material.dart';
import 'onboarding_screen.dart';
import 'phone_input_screen.dart';
import 'otp_verification_screen.dart';
import 'create_name.dart';
import 'message_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingScreen(),
    );
  }
}
