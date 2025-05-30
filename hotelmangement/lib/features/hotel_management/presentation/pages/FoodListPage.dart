// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotelmangement/features/hotel_management/presentation/blocs/foods/bloc/foods_bloc.dart';
// import 'package:hotelmangement/features/hotel_management/presentation/widgets/food_list_tile.dart';

// class FoodListPage extends StatefulWidget {
//   final String managerId;
//   final String hotelId = "550e8400-e29b-41d4-a716-446655440004";
//   const FoodListPage({required this.managerId, super.key});

//   @override
//   State<FoodListPage> createState() => _RoomListPage();
// }

// class _RoomListPage extends State<FoodListPage> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     BlocProvider.of<FoodsBloc>(context)
//         .add(GetFoodsEvent(hotelId: widget.hotelId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FoodsBloc, FoodsState>(
//       buildWhen: (prev, curr) {
//         return curr is FoodLoaded;
//       },
//       builder: (con, state) {
//         if (state is FoodLoaded) {
//           return ListView.builder(
//             itemCount: state.foods.length,
//             itemBuilder: (cont, index) {
//               final food = state.foods[index];
//               return FoodListTile(food: food);
//             },
//           );
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }
// }






//========================================================================================================================


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
  State<FoodListPage> createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<FoodsBloc>(context)
        .add(GetFoodsEvent(hotelId: widget.hotelId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Food Menu',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange[600],
        elevation: 0,
      ),
      body: BlocBuilder<FoodsBloc, FoodsState>(
        buildWhen: (prev, curr) {
          return curr is FoodLoaded || curr is FoodLoading;
        },
        builder: (context, state) {
          if (state is FoodLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            );
          }
          
          if (state is FoodLoaded) {
            if (state.foods.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No food items available',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.foods.length,
                itemBuilder: (context, index) {
                  final food = state.foods[index];
                  return _buildFoodCard(food);
                },
              ),
            );
          }
          
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFoodCard(dynamic food) {
    return Card(
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.orange[50] ?? Colors.orange.shade50,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image Container
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.orange[300] ?? Colors.orange.shade300,
                    Colors.orange[500] ?? Colors.orange.shade500,
                  ],
                ),
              ),
              child: const Icon(
                Icons.fastfood,
                size: 50,
                color: Colors.white,
              ),
            ),
            
            // Food Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Food Name
                        Text(
                          food.name ?? 'Food Item',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        
                        // Food Description
                        if (food.description != null && food.description.isNotEmpty)
                          Text(
                            food.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                    
                    // Price and Action Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange[600],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '\$${food.price?.toStringAsFixed(2) ?? '0.00'}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        
                        // Action Button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.orange[700],
                              size: 20,
                            ),
                            onPressed: () {
                              // Add to cart functionality
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${food.name} added to cart'),
                                  backgroundColor: Colors.orange[600],
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




//===================================================================================================================


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotelmangement/features/hotel_management/presentation/blocs/foods/bloc/foods_bloc.dart';
// import 'package:hotelmangement/features/hotel_management/presentation/widgets/food_list_tile.dart';

// class FoodListPage extends StatefulWidget {
//   final String managerId;
//   final String hotelId = "550e8400-e29b-41d4-a716-446655440004";

//   const FoodListPage({required this.managerId, super.key});

//   @override
//   State<FoodListPage> createState() => _FoodListPageState();
// }

// class _FoodListPageState extends State<FoodListPage> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _loadFoods();
//   }

//   void _loadFoods() {
//     BlocProvider.of<FoodsBloc>(context)
//         .add(GetFoodsEvent(hotelId: widget.hotelId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Food Menu"),
//         centerTitle: true,
//         backgroundColor: Colors.deepOrange,
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async => _loadFoods(),
//         child: BlocBuilder<FoodsBloc, FoodsState>(
//           builder: (context, state) {
//             if (state is FoodLoaded) {
//               if (state.foods.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     "No food items found.",
//                     style: TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                 );
//               }

//               return ListView.separated(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: state.foods.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemBuilder: (context, index) {
//                   final food = state.foods[index];
//                   return AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black12,
//                           blurRadius: 6,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: FoodListTile(food: food),
//                   );
//                 },
//               );
//             } else if (state is FoodError) {
//               return const Center(
//                 child: Text(
//                   "Failed to load food items.",
//                   style: TextStyle(color: Colors.redAccent, fontSize: 16),
//                 ),
//               );
//             }

//             // Default: initial or loading state
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }