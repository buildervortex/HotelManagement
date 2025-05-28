import 'package:flutter/material.dart';

class RatingReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Rating & Reviews'),
        backgroundColor: const Color.fromARGB(255, 250, 224, 254),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search reviews',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.close),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Review Summary and Write Review
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Review Summary',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '+ WRITE A REVIEW',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Star Summary Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                starCircle('5', '30%'),
                starCircle('4', '40%'),
                starCircle('3', '20%'),
                starCircle('2', '15%'),
                starCircle('1', '5%'),
              ],
            ),
            SizedBox(height: 20),

            // Category Ratings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                categoryRating('Rooms', '4.5'),
                categoryRating('Location', '4.8'),
                categoryRating('Service', '4.4'),
              ],
            ),
            SizedBox(height: 16),

            // Overall Rating
            Row(
              children: [
                Text(
                  '4.4',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Very Good',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: List.generate(
                            4,
                            (_) => Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 20,
                            ),
                          ) +
                          [
                            Icon(
                              Icons.star_half,
                              color: Colors.orange,
                              size: 20,
                            ),
                          ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // Reviews List
            Expanded(
              child: ListView(
                children: [
                  reviewTile(
                    'Nice hotel and Great food and have nice things to visit around',
                    '4/5',
                  ),
                  reviewTile("Can't hate this place. Love the place", '5/5'),
                  reviewTile('Good service', '4.5/5'),
                  reviewTile(
                    'Golf is one of the classic hotels in Cote d\'Ivoire. Great service, wonderful pool area situated next to the lagoon. They have also recently renovated most of the amenities. Lovely hotel.',
                    '4.5/5',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget starCircle(String rating, String percent) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: double.parse(percent.replaceAll('%', '')) / 100,
                backgroundColor: Colors.grey.shade200,
                color: Colors.orange,
                strokeWidth: 5,
              ),
            ),
            Column(
              children: [
                Text(rating, style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.star, size: 16, color: Colors.orange),
              ],
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(percent),
      ],
    );
  }

  Widget categoryRating(String label, String rating) {
    return Column(
      children: [
        Text(rating, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  Widget reviewTile(String comment, String score) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(backgroundColor: Colors.grey.shade300),
          title: Text('Customer Name'),
          subtitle: Text('20 mins ago'),
          trailing: Text(score, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Text(comment),
        ),
        Divider(height: 24),
      ],
    );
  }
}
