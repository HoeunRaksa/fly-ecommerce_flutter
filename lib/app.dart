import 'package:flutter/material.dart';
import 'package:fly/core/routing/app_router.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'features/auth/provider/auth_provider.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final router = AppRouter.router(authProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
