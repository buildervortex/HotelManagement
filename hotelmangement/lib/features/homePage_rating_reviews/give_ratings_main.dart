import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RatingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RatingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final supabase = Supabase.instance.client;

  List<dynamic> giveRatings = [];
  bool isLoading = true;
  String? error;

  final String userId = '1234';
  final String hotelId = '01h1';
  final String textPhr = '';
  final String valueImg = '';

  @override
  void initState() {
    super.initState();
    fetchHotelUser();
    fetchHotelHotel();
    fetchHotelText();
    fetchHotelValue();
  }

  Future<void> fetchHotelUser() async {
    try {
      final response =
          await supabase.from('ratings').select().eq('user_id', userId);

      setState(() {
        giveRatings = response;
      });
    } catch (e) {
      setState(() {
        error = 'User fetch error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchHotelHotel() async {
    try {
      final response =
          await supabase.from('ratings').select().eq('hotel_id', hotelId);
    } catch (e) {
      setState(() {
        error = 'Hotel fetch error: $e';
      });
    }
  }

  Future<void> fetchHotelText() async {
    try {
      final response =
          await supabase.from('ratings').select().eq('text', textPhr);
    } catch (e) {
      setState(() {
        error = 'Text fetch error: $e';
      });
    }
  }

  Future<void> fetchHotelValue() async {
    try {
      final response =
          await supabase.from('ratings').select().eq('value', valueImg);
    } catch (e) {
      setState(() {
        error = 'Value fetch error: $e';
      });
    }
  }

  int? selectedEmoji;
  double rating = 0.0;
  final TextEditingController _controller = TextEditingController();

  final List<String> emojis = ['😄', '😀', '😐', '🙁', '😞'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Give Rating & Review'),
        backgroundColor: const Color.fromARGB(255, 250, 224, 254),
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Emoji Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(emojis.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedEmoji = index;
                    });
                  },
                  child: Text(
                    emojis[index],
                    style: TextStyle(
                      fontSize: 32,
                      backgroundColor: selectedEmoji == index
                          ? Colors.yellow.withOpacity(0.3)
                          : Colors.transparent,
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),

            // Review Text Field
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: _controller,
                maxLines: 8,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write your review',
                ),
              ),
            ),
            SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print(
                      "Emoji: ${selectedEmoji != null ? emojis[selectedEmoji!] : "None"}");
                  print("Review: ${_controller.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 50, 98, 243),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            Spacer(),

            // Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
