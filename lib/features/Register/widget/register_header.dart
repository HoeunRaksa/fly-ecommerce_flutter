import 'package:flutter/material.dart';
import '../../../config/app_config.dart';

class RegisterHeader extends StatelessWidget implements PreferredSizeWidget {
  const RegisterHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(30),
      child: Container(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                '${AppConfig.imageUrl}/signup.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: preferredSize.height,
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Enter your account",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(150);
}
