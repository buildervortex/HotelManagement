import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/di/dicontainer.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/tables/bloc/tables_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/pages/TableListPage.dart';

class Tablenavigatorpage extends StatefulWidget {
  final String managerId;
  const Tablenavigatorpage({required this.managerId, super.key});

  @override
  State<Tablenavigatorpage> createState() => _TablenavigatorpageState();
}

class _TablenavigatorpageState extends State<Tablenavigatorpage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gi<TablesBloc>(),
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              builder: (_) => Tablelistpage(managerId: widget.managerId));
        },
      ),
    );
  }
}
