import 'package:flutter/material.dart';


class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> bookings = [
    {
      "image": "assets/booking_history/hotel1.jpg",
      "name": "Heden Golf",
      "rating": 3.9,
      "reviews": 200,
      "date": "23 July 2019",
      "discount": "25% OFF",
      "price": "\$127",
    },
    {
      "image": "assets/booking_history/hotel2.jpg",
      "name": "Sunset Resort",
      "rating": 4.5,
      "reviews": 320,
      "date": "12 June 2021",
      "discount": "30% OFF",
      "price": "\$99",
    },
    {
      "image": "assets/booking_history/hotel5.jpg",
      "name": "Ocean View Hotel",
      "rating": 4.2,
      "reviews": 150,
      "date": "5 March 2023",
      "discount": "20% OFF",
      "price": "\$150",
    },
    {
      "image": "assets/booking_history/hotel4.jpg",
      "name": "Ocean View Hotel",
      "rating": 4.2,
      "reviews": 150,
      "date": "5 March 2023",
      "discount": "20% OFF",
      "price": "\$150",
    },
    {
      "image": "assets/booking_history/hotel3.jpg",
      "name": "Ocean View Hotel",
      "rating": 4.2,
      "reviews": 150,
      "date": "5 March 2023",
      "discount": "20% OFF",
      "price": "\$150",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScale = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking History",
          style: TextStyle(
            color: Colors.black,
            fontSize:
                20 * textScale, // Adjust font size based on textScaleFactor
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                bookings.clear();
              });
            },
            child: Text(
              "Clear All",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16 * textScale,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      "Hotels",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16 * textScale),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: Text(
                      "Date",
                      style: TextStyle(fontSize: 16 * textScale),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: bookings.isEmpty
                  ? Center(child: Text("No bookings available"))
                  : ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        var booking = bookings[index];
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              bookings.removeAt(index);
                            });
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: Card(
                            margin: EdgeInsets.only(bottom: 10),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.04),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      booking["image"],
                                      width: screenWidth *
                                          0.3, // Responsive image width
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.05),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          booking["name"],
                                          style: TextStyle(
                                            fontSize: 12 * textScale,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                color: Colors.amber, size: 10),
                                            Text(
                                              " ${booking["rating"]} (${booking["reviews"]} reviews)",
                                              style: TextStyle(
                                                fontSize: 10 * textScale,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Text(
                                          "Date: ${booking["date"]}",
                                          style: TextStyle(
                                            fontSize: 10 * textScale,
                                          ),
                                        ),
                                        Text(
                                          "Discount: ${booking["discount"]}",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 10 * textScale,
                                          ),
                                        ),
                                        Text(
                                          booking["price"],
                                          style: TextStyle(
                                            fontSize: 10 * textScale,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton(
                                        child: const Text(
                                          'Booking Now',
                                          style: TextStyle(
                                            fontSize: 10, // Minimized font size
                                          ),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
