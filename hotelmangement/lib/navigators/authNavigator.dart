import 'package:flutter/material.dart';
import 'package:hotelmangement/features/auth/home.dart';
import 'package:hotelmangement/features/auth/login.dart';

class Authnavigator extends StatelessWidget {
  const Authnavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }
}
