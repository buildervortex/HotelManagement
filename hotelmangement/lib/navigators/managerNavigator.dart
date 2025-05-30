import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/core/cubit/auth_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/manager_main_page.dart';

class Managernavigator extends StatelessWidget {
  const Managernavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return ManagerMainPage(
        managerId: BlocProvider.of<AuthCubit>(context).clientId);
  }
}
