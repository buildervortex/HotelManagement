import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/active_booking.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/famous_food.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/hotel_state.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/rating_count.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/dashboard/cubit/get_active_table_bookings_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
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
    BlocProvider.of<GetActiveTableBookingsCubit>(context)
        .getActiveTableBookings(DateTime.now(), widget.managerId);
    BlocProvider.of<GetActiveTakeawayBookingsCubit>(context)
        .getActiveTakeawayBookings(DateTime.now(), widget.managerId);
    BlocProvider.of<GetFamousFoodsInAllCubit>(context).getFamousFoods();
    BlocProvider.of<GetHotelRatingsCubit>(context)
        .getHotelRatings(widget.managerId);
    BlocProvider.of<GetHotelStateCubit>(context)
        .getHotelState(widget.managerId);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      children: [
        Card(
          child: BlocBuilder<GetActiveTableBookingsCubit,
              GetActiveTableBookingsState>(
            builder: (cont, state) {
              if (state is GetActiveTableBookingError) {
                return Center(child: Text(state.message));
              } else if (state is GetActiveTableBookingLoaded) {
                return activeTableBookings(state.bookings);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Card(
          child: BlocBuilder<GetActiveTakeawayBookingsCubit,
              GetActiveTakeawayBookingsState>(
            builder: (cont, state) {
              if (state is GetActiveTakeawayBookingsError) {
                return Center(child: Text(state.message));
              } else if (state is GetActiveTakeawayBookingsLoaded) {
                return activeTakeAwayOrderings(state.bookings);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Card(
          child:
              BlocBuilder<GetFamousFoodsInAllCubit, GetFamousFoodsInAllState>(
            builder: (cont, state) {
              if (state is GetFamousFoodsInAllError) {
                return Center(child: Text(state.message));
              } else if (state is GetFamousFoodsInAllLoaded) {
                return famousFoodsInAllHotels(state.famousFoods);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Card(
          child: BlocBuilder<GetHotelRatingsCubit, GetHotelRatingsState>(
            builder: (cont, state) {
              if (state is GetHotelRatingsError) {
                return Center(child: Text(state.message));
              } else if (state is GetHotelRatingsLoaded) {
                return hotelRatings(state.ratings);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Card(
          child: BlocBuilder<GetHotelStateCubit, GetHotelStateState>(
            builder: (cont, state) {
              if (state is GetHotelStateError) {
                return Center(child: Text(state.message));
              } else if (state is GetHotelStateLoaded) {
                return hotelState(state.states);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  Widget activeTableBookings(List<ActiveBooking> bookings) {
    return Column(
      children: [
        Text("Currently Active Table Bookings"),
        Expanded(
          child: PieChart(PieChartData(
            sectionsSpace: 4,
            centerSpaceRadius: 40,
            sections: bookings
                .map(
                  (booking) => PieChartSectionData(
                    value:
                        booking.count != 0 ? booking.count.toDouble() : 0.0001,
                    color: Colors.blue,
                    title: booking.name,
                    radius: 150,
                  ),
                )
                .toList(),
          )),
        ),
      ],
    );
  }

  Widget activeTakeAwayOrderings(List<ActiveBooking> bookings) {
    return Column(
      children: [
        Text("Currently Active Take Away Orders"),
        Expanded(
          child: PieChart(PieChartData(
            sectionsSpace: 4,
            centerSpaceRadius: 40,
            sections: bookings
                .map(
                  (booking) => PieChartSectionData(
                    value:
                        booking.count != 0 ? booking.count.toDouble() : 0.0001,
                    color: Colors.green,
                    title: booking.name,
                    radius: 150,
                  ),
                )
                .toList(),
          )),
        ),
      ],
    );
  }

  Widget famousFoodsInAllHotels(List<FamousFood> foods) {
    return Column(
      children: [
        Text("Faous Foods In Every Hotel"),
        Column(
          children:
              foods.map((food) => ListTile(title: Text(food.name))).toList(),
        )
      ],
    );
  }

  Widget hotelRatings(List<RatingCount> ratings) {
    return Column(
      children: [
        Text("Hotel Ratings"),
        Column(
          children: ratings
              .map((rating) => ListTile(
                    title: Text(rating.name),
                    subtitle: Text(rating.count.toString()),
                  ))
              .toList(),
        )
      ],
    );
  }

  Widget hotelState(List<HotelState> states) {
    return Column(
      children: [
        Text("Hotel State"),
        Column(
          children: states
              .map((state) => Row(
                    children: [
                      Text(state.name),
                      Text(state.foodCount.toString()),
                      Text(state.roomCount.toString()),
                      Text(state.tableCount.toString()),
                    ],
                  ))
              .toList(),
        )
      ],
    );
  }
}
