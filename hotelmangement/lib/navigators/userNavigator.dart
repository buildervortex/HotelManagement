import 'package:flutter/material.dart';
import 'package:hotelmangement/features/onboarding/splash_screen.dart';

class Usernavigator extends StatelessWidget {
  const Usernavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => SplashScreen()),
    );
  }
}
