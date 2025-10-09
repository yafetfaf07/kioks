import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/user-widgets/reviewcard.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;

class Reviewpage extends StatefulWidget {
  final List<dynamic> items;
  final merchantName;
  final merchantId;
  final String userId;

  const Reviewpage({
    super.key,
    required this.items,
    required this.merchantName,
    required this.merchantId,
    required this.userId
  });

  @override
  State<Reviewpage> createState() => _ReviewpageState();
}

class _ReviewpageState extends State<Reviewpage> {
  @override
  Widget build(BuildContext context) {
    // double ratings = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Rate & Review',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body:
      // DeliveryManReview(),
      Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(bottom: 65),
            height: 120,
            child: ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return Reviewcard(
                  itemImagePath: widget.items[index]['imageUrl'],
                  itemName: widget.items[index]['name'],
                  price: widget.items[index]['price'],
                  quantity: widget.items[index]['quantity'],
                );
              },
            ),
          ),
          ItemReview(
            shopName: widget.merchantName,
            merchantId: widget.merchantId,
            userId:widget.userId
          ),
        ],
      ),
    );
  }
}

class DeliveryManReview extends StatelessWidget {
  const DeliveryManReview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ItemReview extends StatefulWidget {
  final String shopName;
  final dynamic merchantId;
  final String userId;
  double ratings;
  ItemReview({
    super.key,
    required this.shopName,
    required this.userId,
    this.ratings = 0.0,
    required this.merchantId,
  });


  @override
  State<ItemReview> createState() => _ItemReviewState();
}

class _ItemReviewState extends State<ItemReview> {

    Future<void> createReview() async {
    final uri = Uri.parse(
      "http://192.168.1.15:5000/api/comments/create/${widget.merchantId}/${widget.userId}",
    );

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"rating": widget.ratings, "content":reviewController.text}),
    );
    if(response.statusCode==201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successful")));
    }else {
      print("Failed");
    }
  }
    TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 0.1, blurRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Shop Name: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                widget.shopName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),

          // Reviewcard(),
          SizedBox(height: 25),

          Center(
            child: Column(
              children: [
                Text(
                  'Rate the item',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder:
                      (context, _) => Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    setState(() {
                      widget.ratings = rating;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 25),

          Center(
            child: Text(
              'Share Your Opinion',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 15),

          TextFormField(
            controller: reviewController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Write your review here....',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              contentPadding: EdgeInsets.all(15.0),
            ),
          ),
          SizedBox(height: 30),

          Center(
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF7B4D), Color(0xFFFE512D)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: MaterialButton(
                onPressed: () {
                  createReview();
                  // Handle submit action
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
