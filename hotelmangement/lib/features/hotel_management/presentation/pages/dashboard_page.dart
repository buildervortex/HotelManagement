import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/active_booking.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/famous_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_state.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/rating_count.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_active_table_bookings_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_active_takeaway_bookings_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_famous_foods_in_all_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_hotel_ratings_cubit.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_hotel_state_cubit.dart';

class ManagerDashboard extends StatefulWidget {
  final String managerId;
  const ManagerDashboard({required this.managerId, super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final now = DateTime.now();
    BlocProvider.of<GetActiveTableBookingsCubit>(context).getActiveTableBookings(now, widget.managerId);
    BlocProvider.of<GetActiveTakeawayBookingsCubit>(context).getActiveTakeawayBookings(now, widget.managerId);
    BlocProvider.of<GetFamousFoodsInAllCubit>(context).getFamousFoods();
    BlocProvider.of<GetHotelRatingsCubit>(context).getHotelRatings(widget.managerId);
    BlocProvider.of<GetHotelStateCubit>(context).getHotelState(widget.managerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6f8),
      appBar: AppBar(
        title: const Text("Manager Dashboard", style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple.shade400,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            buildCard(
              icon: Icons.table_bar,
              color: Colors.indigo,
              title: "Table Bookings",
              child: BlocBuilder<GetActiveTableBookingsCubit, GetActiveTableBookingsState>(
                builder: (_, state) {
                  if (state is GetActiveTableBookingError) {
                    return Center(child: Text(state.message));
                  } else if (state is GetActiveTableBookingLoaded) {
                    return activeTableBookings(state.bookings);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            buildCard(
              icon: Icons.shopping_bag,
              color: Colors.green,
              title: "Takeaway Orders",
              child: BlocBuilder<GetActiveTakeawayBookingsCubit, GetActiveTakeawayBookingsState>(
                builder: (_, state) {
                  if (state is GetActiveTakeawayBookingsError) {
                    return Center(child: Text(state.message));
                  } else if (state is GetActiveTakeawayBookingsLoaded) {
                    return activeTakeAwayOrderings(state.bookings);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            buildCard(
              icon: Icons.star,
              color: Colors.amber.shade700,
              title: "Famous Foods",
              child: BlocBuilder<GetFamousFoodsInAllCubit, GetFamousFoodsInAllState>(
                builder: (_, state) {
                  if (state is GetFamousFoodsInAllError) {
                    return Center(child: Text(state.message));
                  } else if (state is GetFamousFoodsInAllLoaded) {
                    return buildFamousFoodsList(state.famousFoods);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            buildCard(
              icon: Icons.thumb_up,
              color: Colors.purple,
              title: "Hotel Ratings",
              child: BlocBuilder<GetHotelRatingsCubit, GetHotelRatingsState>(
                builder: (_, state) {
                  if (state is GetHotelRatingsError) {
                    return Center(child: Text(state.message));
                  } else if (state is GetHotelRatingsLoaded) {
                    return buildRatingsList(state.ratings);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            buildCard(
              icon: Icons.hotel,
              color: Colors.teal,
              title: "Hotel State",
              child: BlocBuilder<GetHotelStateCubit, GetHotelStateState>(
                builder: (_, state) {
                  if (state is GetHotelStateError) {
                    return Center(child: Text(state.message));
                  } else if (state is GetHotelStateLoaded) {
                    return buildHotelStateList(state.states);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard({required IconData icon, required Color color, required String title, required Widget child}) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }

  Widget activeTableBookings(List<ActiveBooking> bookings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Expanded(
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 35,
              sections: bookings.map((booking) {
                return PieChartSectionData(
                  value: booking.count != 0 ? booking.count.toDouble() : 0.0001,
                  color: _getRandomColor(booking.name),
                  title: '${booking.name}\n(${booking.count})',
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  radius: 60,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget activeTakeAwayOrderings(List<ActiveBooking> bookings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Expanded(
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 35,
              sections: bookings.map((booking) {
                return PieChartSectionData(
                  value: booking.count != 0 ? booking.count.toDouble() : 0.0001,
                  color: _getRandomColor(booking.name),
                  title: '${booking.name}\n(${booking.count})',
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  radius: 60,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFamousFoodsList(List<FamousFood> foods) {
    return ListView.separated(
      itemCount: foods.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.fastfood, color: Colors.orangeAccent),
        title: Text(foods[i].name, style: const TextStyle(fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget buildRatingsList(List<RatingCount> ratings) {
    return ListView.separated(
      itemCount: ratings.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, i) => ListTile(
        leading: const Icon(Icons.star, color: Colors.amber),
        title: Text(ratings[i].name),
        trailing: Chip(
          label: Text(ratings[i].count.toString()),
          backgroundColor: Colors.amber.shade100,
        ),
      ),
    );
  }

  Widget buildHotelStateList(List<HotelState> states) {
    return ListView.builder(
      itemCount: states.length,
      itemBuilder: (_, i) {
        final s = states[i];
        return ListTile(
          leading: const Icon(Icons.domain, color: Colors.teal),
          title: Text(s.name),
          subtitle: Text("Foods: ${s.foodCount}, Rooms: ${s.roomCount}, Tables: ${s.tableCount}"),
        );
      },
    );
  }

  Color _getRandomColor(String key) {
    final hash = key.codeUnits.fold(0, (prev, elem) => prev + elem);
    final colors = [
      Colors.blue, Colors.red, Colors.green, Colors.orange,
      Colors.purple, Colors.pink, Colors.cyan, Colors.teal,
    ];
    return colors[hash % colors.length].withOpacity(0.8);
  }
}



