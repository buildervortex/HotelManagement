import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/tables/bloc/tables_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/widgets/table_list_tile.dart';

class Tablelistpage extends StatefulWidget {
  final String managerId;
  final String hotelId = "550e8400-e29b-41d4-a716-446655440004";
  const Tablelistpage({required this.managerId, super.key});

  @override
  State<Tablelistpage> createState() => _Tablelistpage();
}

class _Tablelistpage extends State<Tablelistpage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<TablesBloc>(context)
        .add(GetTablesEvent(hotelId: widget.hotelId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TablesBloc, TablesState>(
      builder: (con, state) {
        if (state is TableLoaded) {
          return ListView.builder(
            itemCount: state.tables.length,
            itemBuilder: (cont, index) {
              final table = state.tables[index];
              return TableListTile(table: table);
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
