import 'package:flutter/material.dart';
import 'package:fly/app.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:fly/providers/product_provider.dart';
import 'package:fly/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'features/service/user_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        // AuthProvider keeps user and token
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        // UserProvider depends on AuthProvider
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) {
            final authProvider = context.read<AuthProvider>();
            return UserProvider(
              userService: UserService(), // no token here
              authProvider: authProvider,
            );
          },
          update: (_, authProvider, userProvider) {
            // No need to update userService, token is passed per method
            return userProvider!;
          },
        ),


        // ProductProvider
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

