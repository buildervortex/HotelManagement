import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: booking_details()));
}

class booking_details extends StatefulWidget {
  const booking_details({super.key});

  @override
  State<booking_details> createState() => _booking_detailsState();
}

class _booking_detailsState extends State<booking_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Details')),
      body: Column(
        children: [
          Row(children: [Text("Room Details")]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Checkin data & time")]),
              Column(children: [Text("23 july 2019,10:00 AM ")]),
            ],
          ),


            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Checkout data & time")]),
              Column(children: [Text("25 july 2019,10:00 AM ")]),
            ],
          ),



            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("No. of Adults")]),
              Column(children: [Text("2")]),
            ],
          ),




            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("No. of children")]),
              Column(children: [Text("2")]),
            ],
          ),



            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("No.of room")]),
              Column(children: [Text("1")]),
            ],
          ),


           Divider(),


            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Price")]),
              Column(children: [Text("'\$125'")]),
            ],
          ),



            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Tax")]),
              Column(children: [Text("'\$20'")]),
            ],
          ),


            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Total")]),
              Column(children: [Text("'\$145'")]),
            ],
          ),
          
          Divider(),


            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Food details")]),
            
            ],
          ),


           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Bagels with turkey and bacon")]),
              Column(children: [Text("'\$10'")]),
            ],
          ),


           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Sandwich")]),
              Column(children: [Text("'\$5'")]),
            ],
          ),
          
          Divider(),

           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Sub total")]),
              Column(children: [Text("'\$15'")]),
            ],
          ),

          Divider(),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Service tax")]),
              Column(children: [Text("'\$2'")]),
            ],
          ),


          Divider(),

            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [Text("Total")]),
              Column(children: [Text("'\$17'")]),
            ],
          ),


            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             ElevatedButton(onPressed: (){}, child: Text("Book again"))
            ],
          ),

         

          
        ],
      ),
    );
  }
}
