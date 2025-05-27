import 'package:flutter/material.dart';
import 'package:hotelmangement/features/display_hotel/Model/hotel_category_model.dart';
import 'package:hotelmangement/features/display_hotel/Model/hotel_model.dart';
import 'package:hotelmangement/features/display_hotel/Views/Widgects/hotel_card.dart';
import 'package:hotelmangement/features/display_hotel/Views/hotel_detail_screen.dart';


class SearchHotel extends StatefulWidget {
  const SearchHotel({super.key});

  @override
  _SearchHotelState createState() => _SearchHotelState();
}

class _SearchHotelState extends State<SearchHotel> {
  final TextEditingController _searchController = TextEditingController();
  List<HotelModel> filteredHotels = hotelModel;
  String selectedCategory = "All"; // Default category selection

  // Function to filter hotels based on category and search query
  void _filterHotels() {
    String query = _searchController.text.toLowerCase();

    setState(() {
      filteredHotels = hotelModel.where((hotel) {
        bool matchesQuery = hotel.name.toLowerCase().contains(query);
        bool matchesCategory = selectedCategory == "All" || hotel.category == selectedCategory;
        return matchesQuery && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Search")),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) => _filterHotels(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          hintText: "Search Hotels",
                          hintStyle: TextStyle(color: Colors.black38),
                          filled: true,
                          fillColor: Colors.grey[200],
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.brown),
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.black38),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Hotel Category Selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: hotelcategory.map((category) {
                    bool isSelected = selectedCategory == category.name;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = category.name;
                        });
                        _filterHotels();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.brown : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Text(
                            category.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            SizedBox(height: 10),

            // Hotel List with "No hotels found" message
            Expanded(
              child: filteredHotels.isEmpty
                  ? Center(
                      child: Text(
                        "No hotels found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredHotels.length,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      itemBuilder: (context, index) {
                        final hotelItems = filteredHotels[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HotelDetailScreen(hotelItem: hotelItems),
                                ),
                              );
                            },
                            child: HotelCard(hotelItems: hotelItems, size: size),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
