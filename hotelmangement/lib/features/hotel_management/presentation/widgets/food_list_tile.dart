import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/food_image.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/foods/bloc/foods_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/widgets/item_list_tile.dart';

class FoodListTile extends StatefulWidget {
  final Food food;
  const FoodListTile({required this.food, super.key});

  @override
  State<FoodListTile> createState() => _RoomListTileState();
}

class _RoomListTileState extends State<FoodListTile> {
  List<FoodImage> _cachedImages = [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<FoodsBloc, FoodsState>(
      listenWhen: (prev, curr) =>
          curr is FoodImageLoaded && curr.foodId == widget.food.id,
      listener: (cont, state) {
        if (state is FoodImageLoaded && state.foodId == widget.food.id) {
          setState(() {
            _cachedImages = state.images;
          });
        }
      },
      child: ItemListTile(
        title: widget.food.name,
        subtitile: widget.food.type,
        images: _cachedImages,
      ),
    );
  }
}
