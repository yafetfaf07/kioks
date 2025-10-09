import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/reviewpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

var dates = DateTime.now();

class OrderItem extends StatelessWidget {
  final merchantName;
  final merchantId;
  final date;
  final String userId;
  final List<dynamic> items;
  const OrderItem({super.key, required this.merchantName, required this.date, required this.items, required this.merchantId, required this.userId});



  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(date as String);
    String formattedDate = DateFormat("MMM dd, yyyy hh:mm a").format(parsedDate);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Reviewpage(items:items, merchantName:merchantName, merchantId:merchantId, userId:userId)));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(color: Colors.blueAccent),
                ),
                Column(
                  children: [
                    Text(merchantName),
                    Text(formattedDate),
                  ],
                ),
                Text("${items.length}item"),
              ],
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
