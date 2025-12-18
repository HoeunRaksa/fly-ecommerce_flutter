import 'dart:ui';
import 'package:flutter/material.dart';

class SplashBottom extends StatelessWidget {
  const SplashBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Register
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      print("Register pressed");
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,

                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                // Sign In button
                Container(
                  padding: EdgeInsets.zero,
                  width: 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      print("Sign In pressed");
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,

                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
