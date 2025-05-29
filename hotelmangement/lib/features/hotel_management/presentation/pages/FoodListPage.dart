import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/foods/bloc/foods_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/widgets/food_list_tile.dart';

class FoodListPage extends StatefulWidget {
  final String managerId;
  final String hotelId = "550e8400-e29b-41d4-a716-446655440004";
  const FoodListPage({required this.managerId, super.key});

  @override
  State<FoodListPage> createState() => _RoomListPage();
}

class _RoomListPage extends State<FoodListPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<FoodsBloc>(context)
        .add(GetFoodsEvent(hotelId: widget.hotelId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodsBloc, FoodsState>(
      buildWhen: (prev, curr) {
        return curr is FoodLoaded;
      },
      builder: (con, state) {
        if (state is FoodLoaded) {
          return ListView.builder(
            itemCount: state.foods.length,
            itemBuilder: (cont, index) {
              final food = state.foods[index];
              return FoodListTile(food: food);
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
