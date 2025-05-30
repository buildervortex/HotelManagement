import 'package:flutter/material.dart';
import 'package:hotelmangement/features/hotel_management/presentation/widgets/item_list_tile.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/table.dart'
    as t;

class TableListTile extends StatefulWidget {
  final t.Table table;
  const TableListTile({required this.table, super.key});

  @override
  State<TableListTile> createState() => _TableListTileState();
}

class _TableListTileState extends State<TableListTile> {
  @override
  Widget build(BuildContext context) {
    return ItemListTile(
      title: widget.table.tableNumber,
      subtitile: widget.table.floor,
      images: [],
    );
  }
}
