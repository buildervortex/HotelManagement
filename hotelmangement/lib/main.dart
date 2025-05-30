import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/core/cubit/auth_cubit.dart';
import 'package:hotelmangement/core/initialize.dart';
import 'package:hotelmangement/di/dicontainer.dart';

import 'package:hotelmangement/features/hotel_management/presentation/pages/manager_main_page.dart';
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
        home: ManagerMainPage(
          managerId: "e8b2c4e6-353a-450d-ab3a-08a0676fd773",
        ),
      ),
    );
  }
}
