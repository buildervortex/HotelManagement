// import 'package:flutter/material.dart';
// import 'package:hotelmangement/features/display_hotel/Model/hotel_category_model.dart';
// import 'package:hotelmangement/features/display_hotel/Model/hotel_model.dart';
// import 'package:hotelmangement/features/display_hotel/Views/Widgects/hotel_card.dart';
// import 'package:hotelmangement/features/display_hotel/Views/hotel_detail_screen.dart';

// class SearchHotel extends StatefulWidget {
//   const SearchHotel({super.key});

//   @override
//   _SearchHotelState createState() => _SearchHotelState();
// }

// class _SearchHotelState extends State<SearchHotel> {
//   final TextEditingController _searchController = TextEditingController();
//   List<HotelModel> filteredHotels = hotelModel;
//   String selectedCategory = "All"; // Default category selection

//   // Function to filter hotels based on category and search query
//   void _filterHotels() {
//     String query = _searchController.text.toLowerCase();

//     setState(() {
//       filteredHotels = hotelModel.where((hotel) {
//         bool matchesQuery = hotel.name.toLowerCase().contains(query);
//         bool matchesCategory = selectedCategory == "All" || hotel.category == selectedCategory;
//         return matchesQuery && matchesCategory;
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text("Search")),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 20),

//             // Search Bar
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Row(
//                 children: [
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: SizedBox(
//                       height: 45,
//                       child: TextField(
//                         controller: _searchController,
//                         onChanged: (value) => _filterHotels(),
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                           hintText: "Search Hotels",
//                           hintStyle: TextStyle(color: Colors.black38),
//                           filled: true,
//                           fillColor: Colors.grey[200],
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//                             borderSide: BorderSide(color: Colors.brown),
//                           ),
//                           prefixIcon: Icon(Icons.search, color: Colors.black38),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 20),

//             // Hotel Category Selection
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: hotelcategory.map((category) {
//                     bool isSelected = selectedCategory == category.name;
//                     return InkWell(
//                       onTap: () {
//                         setState(() {
//                           selectedCategory = category.name;
//                         });
//                         _filterHotels();
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.only(right: 8),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                           decoration: BoxDecoration(
//                             color: isSelected ? Colors.brown : Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(color: Colors.black12),
//                           ),
//                           child: Text(
//                             category.name,
//                             style: TextStyle(
//                               color: isSelected ? Colors.white : Colors.black87,
//                               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),

//             SizedBox(height: 10),

//             // Hotel List with "No hotels found" message
//             Expanded(
//               child: filteredHotels.isEmpty
//                   ? Center(
//                       child: Text(
//                         "No hotels found",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: filteredHotels.length,
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       itemBuilder: (context, index) {
//                         final hotelItems = filteredHotels[index];
//                         return Padding(
//                           padding: EdgeInsets.only(bottom: 20),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => HotelDetailScreen(hotelItem: hotelItems),
//                                 ),
//                               );
//                             },
//                             child: HotelCard(hotelItems: hotelItems, size: size),
//                           ),
//                         );
//                       },
//                     ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



// New Update

import 'package:flutter/material.dart';
import 'package:hotelmangement/features/display_hotel/Model/hotel_model_test.dart';
import 'package:hotelmangement/features/display_hotel/Views/Widgects/hotel_card.dart';
import 'package:hotelmangement/features/display_hotel/Views/hotel_detail_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchHotel extends StatefulWidget {
  const SearchHotel({super.key});

  @override
  State<SearchHotel> createState() => _SearchHotelState();
}

class _SearchHotelState extends State<SearchHotel> {
  final supabase = Supabase.instance.client;
  List<ExtendedHotel> extendedHotels = [];
  List<ExtendedHotel> filteredHotels = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadHotels();
  }

  void _loadHotels() async {
    final hotelList = await supabase.from("hotel").select();
    List<Hotel> hotels = hotelList.map((hotel) => Hotel.fromJson(hotel)).toList();
    List<ExtendedHotel> extHotels = [];

    for (Hotel hotel in hotels) {
      final images = await supabase.from("hotel_image").select().eq("hotel_id", hotel.id);
      final phoneNumbers = await supabase.from("hotel_phone_number").select().eq("hotel_id", hotel.id);

      List<String> hotelImageUrls = [];
      for (var image in images) {
        final url = await supabase.storage
            .from("hotelimage")
            .createSignedUrl(image["file"], 60 * 60 * 60);
        hotelImageUrls.add(url);
      }

      extHotels.add(ExtendedHotel(
        hotel: hotel,
        phoneNumbers: phoneNumbers.map((num) => HotelPhoneNumber.fromJson(num)).toList(),
        hotelImageList: hotelImageUrls,
      ));
    }

    setState(() {
      extendedHotels = extHotels;
      filteredHotels = extHotels;
    });
  }

  void _filterHotels(String query) {
    setState(() {
      searchQuery = query;
      filteredHotels = extendedHotels
          .where((hotel) => hotel.hotel.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Search Hotels")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: _filterHotels,
              decoration: const InputDecoration(
                hintText: 'Search by hotel name',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredHotels.length,
              itemBuilder: (context, index) {
                final hotel = filteredHotels[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HotelDetailScreen(hotel: hotel),
                      ),
                    );
                  },
                  child: HotelCard(hotelData: hotel, size: size),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



