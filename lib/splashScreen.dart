import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:demo_project/auth/view/index.dart';

class SplashScreen extends StatelessWidget {
  static const String name = 'splashscreen';
  const SplashScreen({super.key});

  void redirectToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // context.goNamed(Homepage.name);
      context.goNamed(Loginpage.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    redirectToHome(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/shopping_cart.json',
              width: 150,
              height: 150,
            ),
            // const SizedBox(height: 20),
            // const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
