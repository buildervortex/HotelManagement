import 'package:flutter/material.dart';
import 'package:hotelmangement/features/user/UserPage.dart';

class Usernavigator extends StatelessWidget {
  const Usernavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (_) => Userpage()),
    );
  }
}
