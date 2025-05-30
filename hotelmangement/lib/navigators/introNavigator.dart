import 'package:flutter/material.dart';
import 'package:hotelmangement/features/auth/login.dart';

class Intronavigator extends StatelessWidget {
  const Intronavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }
}
