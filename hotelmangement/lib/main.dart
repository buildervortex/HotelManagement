import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/core/cubit/auth_cubit.dart';
import 'package:hotelmangement/core/initialize.dart';
import 'package:hotelmangement/di/dicontainer.dart';

import 'package:hotelmangement/navigators/authNavigator.dart';
import 'package:hotelmangement/navigators/introNavigator.dart';
import 'package:hotelmangement/navigators/managerNavigator.dart';
import 'package:hotelmangement/navigators/userNavigator.dart';
import 'package:hotelmangement/test.dart';

void main() async {
  // ensure the flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // initialize the project
  await initializeProject();

  // testing porpose only
  final testResult = await initTest();
  if (testResult != 1) {
    runApp(BlocProvider<AuthCubit>(
      create: (context) => gi<AuthCubit>(),
      child: const MyApp(),
    ));
  }
}

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is LogOut) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil("/login", (route) => false);
        } else if (state is LoggingUser) {
          if (state.isManager) {
            _navigatorKey.currentState
                ?.pushNamedAndRemoveUntil("/manager", (route) => false);
          } else {
            _navigatorKey.currentState
                ?.pushNamedAndRemoveUntil("/user", (route) => false);
          }
        }
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        navigatorKey: _navigatorKey,
        initialRoute: "/user",
        onGenerateRoute: _generateRoutes,
      ),
    );
  }

  Route<dynamic> _generateRoutes(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case "/intro":
        return MaterialPageRoute(builder: (_) => Intronavigator());
      case "/login":
        return MaterialPageRoute(builder: (_) => Authnavigator());
      case "/manager":
        return MaterialPageRoute(builder: (_) => Managernavigator());
      case "/user":
        return MaterialPageRoute(builder: (_) => Usernavigator());
      default:
        return MaterialPageRoute(
            builder: (_) => Center(child: Text("unknown route")));
    }
  }
}
