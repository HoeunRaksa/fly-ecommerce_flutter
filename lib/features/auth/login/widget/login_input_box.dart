import 'package:flutter/material.dart';
import 'package:fly/config/app_config.dart';
import 'package:fly/core/widgets/e_button.dart';
import 'package:fly/core/widgets/input_field.dart';

import '../../../../config/app_color.dart';

class LoginInput extends StatefulWidget {
  const LoginInput({super.key});

  @override
  State<LoginInput> createState() => _LoginInput();
}

class _LoginInput extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.white, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray700.withOpacity(0.2), // shadow color
            spreadRadius: 2, // how wide the shadow spreads
            blurRadius: 8, // softening
            offset: const Offset(0, 4), // x, y offset
          ),
        ],
      ),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign In",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                spaceX(5),
                Text(
                  "Forget password",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                spaceX(20),
              ],
            ),
          ),
          InputField(label: "username"),
          spaceX(20),
          InputField(label: "password"),
          spaceX(40),
          EButton(name: "Login", onPressed: () {}),
          spaceX(20),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.grey, // or AppColors.gray700
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "or",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Colors.grey, // or AppColors.gray700
                      thickness: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          spaceX(20),
          GestureDetector(
            onTap: () {
              print("Google Sign-In clicked");
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.gray700.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray700.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Small white container for image
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        "${AppConfig.imageUrl}/google.png",
                        height: 25,
                      ),
                    ),
                  ),
                  // Centered text
                  Text(
                    "Sign In with Google",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),

          spaceX(20),
          GestureDetector(
            onTap: () {
              print("Facebook Sign-In clicked");
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.secondaryBlue,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray700.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        "${AppConfig.imageUrl}/facebook.png",
                        height: 25,
                      ),
                    ),
                  ),
                  Text(
                    "Sign In with Facebook",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: AppColors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget spaceX(double x) {
    return SizedBox(height: x);
  }
}
