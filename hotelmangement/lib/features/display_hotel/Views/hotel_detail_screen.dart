// import 'package:flutter/material.dart';
// import 'package:hotel_management/Model/hotel_model.dart';
// import 'package:hotel_management/Views/available_food.dart';

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
//                   // Hotel Name & Rating
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
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
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
//                   const SizedBox(height: 15),
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
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
//                   // Check Available Food Button
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
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
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
// }





import 'package:flutter/material.dart';
import 'package:hotel_management/Model/hotel_model.dart';
import 'package:hotel_management/Views/available_food.dart';

class HotelDetailScreen extends StatefulWidget {
  final HotelModel hotelItem;

  const HotelDetailScreen({super.key, required this.hotelItem});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  int currentIndex = 0;
  int _selectedIndex = -1; // -1 means nothing selected yet

  final List<String> labels = ["Review (106)", "Photo (10)", "Near by (26)"];

  Widget getSelectedSection() {
    if (_selectedIndex == 0) {
      return SizedBox(
        height: 170,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              ReviewCard(
                imageUrl: 'assets/user1.jpg',
                userName: 'John Doe',
                review:
                    'Amazing place! The rooms were clean and the service was great.',
              ),
              ReviewCard(
                imageUrl: 'assets/user2.jpg',
                userName: 'Jane Smith',
                review: 'Lovely location. Friendly staff.',
              ),
              ReviewCard(
                imageUrl: 'assets/user3.jpg',
                userName: 'Michael Lee',
                review: 'Value for money. Will visit again!',
              ),
            ],
          ),
        ),
      );
    } else if (_selectedIndex == 1) {
      return const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text("Photo section goes here..."),
      );
    } else if (_selectedIndex == 2) {
      return const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("- Hilton Hotel"),
            Text("- Paradise Inn"),
            Text("- City Lodge"),
          ],
        ),
      );
    }
    return Container(); // Show nothing by default
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Hotel Detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image carousel
            SizedBox(
              height: size.height * 0.3,
              width: size.width,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Hero(
                        tag: widget.hotelItem.image,
                        child: Image.asset(
                          widget.hotelItem.image,
                          height: size.height * 0.25,
                          width: size.width * 0.9,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 4),
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == currentIndex
                                  ? Colors.blue
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel name and rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.hotelItem.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            widget.hotelItem.rating.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Location and phone
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.blueGrey, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        widget.hotelItem.location,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        widget.hotelItem.Mobile.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Toggle buttons
                  ToggleButtons(
                    borderRadius: BorderRadius.circular(25),
                    borderColor: Colors.brown,
                    selectedBorderColor: Colors.brown,
                    fillColor: Colors.brown,
                    selectedColor: Colors.white,
                    color: Colors.black,
                    constraints:
                        const BoxConstraints(minWidth: 110, minHeight: 40),
                    isSelected: List.generate(
                        labels.length, (index) => index == _selectedIndex),
                    onPressed: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    children: labels
                        .map((label) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(label),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 15),

                  // Section content (only shown when one is selected)
                  getSelectedSection(),

                  const SizedBox(height: 15),

                  // Facilities
                  const Text(
                    "Common Facilities",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: widget.hotelItem.Facilities.map((facility) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10, top: 10),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.brown),
                          ),
                          child: Center(
                            child: Text(
                              facility,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Description
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.hotelItem.description,
                    style: const TextStyle(
                        fontSize: 16, color: Colors.black38),
                  ),
                  const SizedBox(height: 20),

                  // Check Available Food Button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AvailableFoodPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.fastfood),
                      label: const Text("Check Available Food"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        color: const Color.fromARGB(255, 147, 113, 113),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Price",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600)),
                Text(
                  "Rs: ${widget.hotelItem.price}",
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text("Book Now",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------
// ReviewCard Widget
// ----------------------------
class ReviewCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String review;

  const ReviewCard({
    super.key,
    required this.imageUrl,
    required this.userName,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                radius: 25,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(review,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
