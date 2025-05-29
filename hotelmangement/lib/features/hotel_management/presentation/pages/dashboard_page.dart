import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/di/dicontainer.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/dashboard/get_active_table_bookings.dart';

class ManagerDashboard extends StatefulWidget {
  final String managerId;
  const ManagerDashboard({required this.managerId, super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (con)=> gi<GetActiveTableBookings>()),
        BlocProvider(create: (con)=> gi<GetActiveTableBookings>()),
        BlocProvider(create: (con)=> gi<GetActiveTableBookings>()),
        BlocProvider(create: (con)=> gi<GetActiveTableBookings>()),
      ],
      child: ,
    );
  }
}
