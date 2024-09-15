import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:digiwallet/screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2000,
      splash: Column(
        children: [
          Center(
            child: SizedBox(
              height: 500,
              child: LottieBuilder.asset(
                "assets/lottie/Animation - 1726249324920.json",
              ),
            ),
          ),
        ],
      ),
      nextScreen: const Journey(),
      splashIconSize: 600,
      backgroundColor: Color(0xFFB7D1EC),
    );
  }
}
