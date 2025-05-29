import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/di/dicontainer.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/foods/bloc/foods_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/FoodListPage.dart';

class Foodnavigatorpage extends StatefulWidget {
  final String managerId;
  const Foodnavigatorpage({required this.managerId, super.key});

  @override
  State<Foodnavigatorpage> createState() => _FoodnavigatorpageState();
}

class _FoodnavigatorpageState extends State<Foodnavigatorpage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gi<FoodsBloc>(),
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              builder: (_) => FoodListPage(managerId: widget.managerId));
        },
      ),
    );
  }
}
