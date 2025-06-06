// import 'package:flutter/material.dart';
// import 'package:hotelmangement/features/display_hotel/Model/hotel_model.dart';
// import 'package:hotelmangement/features/display_hotel/Views/Widgects/nearbyhotel_card.dart';
// import 'package:hotelmangement/features/display_hotel/Views/Widgects/review_card.dart';
// import 'package:hotelmangement/features/display_hotel/Views/available_food.dart';

// class HotelDetailScreen extends StatefulWidget {
//   final HotelModel hotelItem;

//   const HotelDetailScreen({super.key, required this.hotelItem});

//   @override
//   State<HotelDetailScreen> createState() => _HotelDetailScreenState();
// }

// class _HotelDetailScreenState extends State<HotelDetailScreen> {
//   int currentIndex = 0;
//   int _selectedIndex = 0;

//   final List<String> labels = ["Review (106)", "Photo (10)", "Near by (26)"];

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Hotel Detail"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Hotel image carousel
//             SizedBox(
//               height: size.height * 0.3,
//               width: size.width,
//               child: PageView.builder(
//                 onPageChanged: (value) {
//                   setState(() {
//                     currentIndex = value;
//                   });
//                 },
//                 itemCount: 3,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Hero(
//                         tag: widget.hotelItem.image,
//                         child: Image.asset(
//                           widget.hotelItem.image,
//                           height: size.height * 0.25,
//                           width: size.width * 0.9,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(
//                           3,
//                           (index) => AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             margin: const EdgeInsets.only(right: 4),
//                             width: 7,
//                             height: 7,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: index == currentIndex
//                                   ? Colors.blue
//                                   : Colors.grey.shade400,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(18),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Hotel name and rating
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         widget.hotelItem.name,
//                         style: const TextStyle(
//                           color: Colors.black87,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           const Icon(Icons.star,
//                               color: Color.fromARGB(255, 236, 213, 7),
//                               size: 18),
//                           const SizedBox(width: 5),
//                           Text(
//                             widget.hotelItem.rating.toString(),
//                             style: const TextStyle(
//                                 color: Colors.black, fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),

//                   // Location
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on,
//                           color: Colors.blueGrey, size: 18),
//                       const SizedBox(width: 5),
//                       Text(
//                         widget.hotelItem.location,
//                         style: const TextStyle(
//                             color: Colors.black54, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),

//                   // Mobile
//                   Row(
//                     children: [
//                       const Icon(Icons.phone, color: Colors.blueGrey, size: 18),
//                       const SizedBox(width: 5),
//                       Text(
//                         widget.hotelItem.Mobile.toString(),
//                         style: const TextStyle(
//                             color: Colors.black54, fontSize: 16),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 15),

//                   // Toggle Buttons
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     child: ToggleButtons(
//                       borderRadius: BorderRadius.circular(25),
//                       borderColor: Colors.brown,
//                       selectedBorderColor: Colors.brown,
//                       fillColor: Colors.brown,
//                       selectedColor: Colors.white,
//                       color: Colors.black,
//                       constraints:
//                           const BoxConstraints(minWidth: 110, minHeight: 40),
//                       isSelected: List.generate(
//                           labels.length, (index) => index == _selectedIndex),
//                       onPressed: (index) {
//                         setState(() {
//                           _selectedIndex = index;
//                         });
//                       },
//                       children: labels
//                           .map((label) => Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Text(label),
//                               ))
//                           .toList(),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Dynamic Section
//                   getSelectedSection(),

//                   const SizedBox(height: 30),

//                   // Common Facilities
//                   const Text(
//                     "Common Facilities",
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 10),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: widget.hotelItem.Facilities.map((facility) {
//                         return Container(
//                           margin: const EdgeInsets.only(right: 10, top: 10),
//                           height: 60,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(color: Colors.brown),
//                           ),
//                           child: Center(
//                             child: Text(
//                               facility,
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 10,
//                               ),
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   const SizedBox(height: 15),

//                   // Description
//                   const Text(
//                     "Description",
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black87,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     widget.hotelItem.description,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black38,
//                       letterSpacing: -.5,
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Check Available Food
//                   Center(
//                     child: ElevatedButton.icon(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => const AvailableFoodPage(),
//                           ),
//                         );
//                       },
//                       icon: const Icon(Icons.fastfood),
//                       label: const Text("Check Available Food"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.brown,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 25, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),

//       // Bottom Price & Book Now
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 147, 113, 113),
//           border: Border(
//             top: BorderSide(color: Colors.grey.shade300),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Price",
//                   style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   "Rs: ${widget.hotelItem.price}",
//                   style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.brown,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
//               ),
//               child: const Text(
//                 "Book Now",
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Section Switcher
//   Widget getSelectedSection() {
//     if (_selectedIndex == 0) {
//       // Review Section
//       return SizedBox(
//         height: 170,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: const [
//               ReviewCard(
//                 imageUrl: 'assets/user1.jpg',
//                 userName: 'John Doe',
//                 review:
//                     'Amazing place! The rooms were clean and the service was great.',
//               ),
//               ReviewCard(
//                 imageUrl: 'assets/user2.jpg',
//                 userName: 'Jane Smith',
//                 review: 'Lovely location. Friendly staff.',
//               ),
//               ReviewCard(
//                 imageUrl: 'assets/user3.jpg',
//                 userName: 'Michael Lee',
//                 review: 'Value for money. Will visit again!',
//               ),
//             ],
//           ),
//         ),
//       );
//     } else if (_selectedIndex == 1) {
//       // Photo Section
//       return SizedBox(
//         height: 180,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               hotelPhotoCard('assets/photo1.jpg'),
//               hotelPhotoCard('assets/photo2.jpg'),
//               hotelPhotoCard('assets/photo3.jpg'),
//             ],
//           ),
//         ),
//       );
//     } else if (_selectedIndex == 2) {
//       // Nearby Hotels Section
//       return SizedBox(
//         height: 170,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: const [
//               NearbyCard(
//                 hotelName: 'Hilton Grand',
//                 distance: '500m away',
//                 imageUrl: 'assets/hotel1.jpg',
//               ),
//               NearbyCard(
//                 hotelName: 'Sunset Resort',
//                 distance: '1.2km away',
//                 imageUrl: 'assets/hotel2.jpg',
//               ),
//               NearbyCard(
//                 hotelName: 'City Lodge',
//                 distance: '750m away',
//                 imageUrl: 'assets/hotel3.jpg',
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//     return Container();
//   }

//   Widget hotelPhotoCard(String imagePath) {
//     return Container(
//       margin: const EdgeInsets.only(right: 10),
//       height: 160,
//       width: 240,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         image:
//             DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
//       ),
//     );
//   }
// }

// New Update

import 'package:flutter/material.dart';
import 'package:hotelmangement/features/booking/BookingScaffold.dart';
import 'package:hotelmangement/features/booking/room_booking.dart';
import 'package:hotelmangement/features/display_hotel/Model/hotel_model_test.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HotelDetailScreen extends StatelessWidget {
  final ExtendedHotel hotel;

  const HotelDetailScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel Detail"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          if (hotel.hotelImageList.isNotEmpty)
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: hotel.hotelImageList.length,
                itemBuilder: (context, index) => Image.network(
                  hotel.hotelImageList[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.hotel.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      Text(hotel.hotel.address),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16),
                      Text(hotel.phoneNumbers.isNotEmpty
                          ? hotel.phoneNumbers[0].number
                          : "N/A"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: hotel.hotel.rating,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 20.0,
                      ),
                      const SizedBox(width: 8),
                      Text(hotel.hotel.rating.toString()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTabBarSection(),
                  const SizedBox(height: 12),
                  _buildReviewSection(),
                  const SizedBox(height: 16),
                  const Text("Common Facilities",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    children: [
                      _buildFacilityChip("AC"),
                      _buildFacilityChip("Restaurant"),
                      _buildFacilityChip("Swimming Pool"),
                      _buildFacilityChip("24 Hours Front Desk"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildTabBarSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _TabItem(label: "Review (106)", isActive: true),
          _TabItem(label: "Photo (10)", isActive: false),
          _TabItem(label: "Near by (26)", isActive: false),
        ],
      ),
    );
  }

  Widget _buildReviewSection() {
    return Row(
      children: [
        _buildReviewCard("John Doe",
            "Amazing place! The rooms were clean and the service was great."),
        const SizedBox(width: 10),
        _buildReviewCard("Jane Smith", "Lovely location. Friendly staff."),
      ],
    );
  }

  Widget _buildReviewCard(String name, String comment) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            CircleAvatar(child: Text(name[0])),
            const SizedBox(height: 6),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(comment, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilityChip(String label) {
    return Chip(
      label: Text(label),
      shape: const StadiumBorder(),
      backgroundColor: Colors.brown[50],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      color: Colors.brown[300],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Price\nRs: ${hotel.hotel.price.toInt()}",
              style: const TextStyle(color: Colors.white, fontSize: 16)),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Bookingscaffold(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
            child: const Text("Book Now"),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;

  const _TabItem({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.brown : Colors.transparent,
        border: Border.all(color: Colors.brown),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.brown,
          )),
    );
  }
}
