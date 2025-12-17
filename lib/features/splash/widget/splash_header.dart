import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../config/app_config.dart';

class SplashHeader extends StatelessWidget implements PreferredSizeWidget {
  const SplashHeader({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(430);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 10),
            ),
          ],
        ),
        height: preferredSize.height,
        padding: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment(0,0.0),
          children: [
            Image.asset(
              '${AppConfig.imageUrl}/splash.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            FractionallySizedBox(
              heightFactor:0.8,
              child:  Image.asset(
                '${AppConfig.imageUrl}/character.png',
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}
