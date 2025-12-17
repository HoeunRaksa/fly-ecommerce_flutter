import 'package:flutter/material.dart';
import 'package:fly/features/splash/widget/splash_body.dart';
import 'package:fly/features/splash/widget/splash_bottom.dart';
import 'dart:async';
import 'package:fly/features/splash/widget/splash_header.dart';
import '../../../core/colors/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate a delay (e.g., check login or load resources)
    Timer(const Duration(seconds: 3), () {
      // Navigate to Login or Home
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      appBar: SplashHeader(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SplashBody(),
              SizedBox(height: 40,),
              SplashBottom()
            ],
          ),
        ),
      ),
    );
  }
}
