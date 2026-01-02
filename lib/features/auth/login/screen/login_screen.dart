import 'package:flutter/material.dart';
import '../widget/background_login.dart';
import '../widget/login_body.dart';
import '../widget/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: LoginHeader(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BackgroundLogin(),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
                  child: const LoginBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
