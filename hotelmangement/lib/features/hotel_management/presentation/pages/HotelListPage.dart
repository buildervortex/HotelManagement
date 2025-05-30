import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/blocs/hotels/bloc/hotels_bloc.dart';
import 'package:hotelmangement/features/hotel_management/presentation/widgets/hotel_list_tile.dart';

class Hotellistpage extends StatefulWidget {
  final String managerId;
  const Hotellistpage({required this.managerId, super.key});

  @override
  State<Hotellistpage> createState() => _HotellistpageState();
}

class _HotellistpageState extends State<Hotellistpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<HotelsBloc>(context)
        .add(GetHotelsEvent(managerId: widget.managerId));
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.white;
    final secondaryColor = Colors.white;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              secondaryColor.withOpacity(0.3),
              primaryColor.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Hotels',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed("/createHotel");
                },
                icon: const Icon(Icons.add, size: 24),
                label: Text(
                  "Create Hotel",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color:Colors.green,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Colors.black45,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<HotelsBloc, HotelsState>(
                buildWhen: (prev, curr) => curr is HotelLoaded,
                builder: (context, state) {
                  if (state is HotelLoaded) {
                    if (state.hotels.isEmpty) {
                      return Center(
                        child: Text(
                          "No hotels found.\nTap 'Create Hotel' to add one.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    _animationController.forward();

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.hotels.length,
                      itemBuilder: (context, index) {
                        final hotel = state.hotels[index];
                        final animation = Tween<Offset>(
                          begin: const Offset(0, 0.1),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Interval(
                            (index / state.hotels.length),
                            1.0,
                            curve: Curves.easeOut,
                          ),
                        ));

                        return SlideTransition(
                          position: animation,
                          child: FadeTransition(
                            opacity: _animationController,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    offset: const Offset(0, 6),
                                    blurRadius: 12,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Colors.teal.withOpacity(0.1),
                                    offset: const Offset(0, 3),
                                    blurRadius: 6,
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.teal.shade200,
                                  width: 1.2,
                                ),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: HotelListTile(hotel: hotel),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3.5,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Loading hotels...',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

