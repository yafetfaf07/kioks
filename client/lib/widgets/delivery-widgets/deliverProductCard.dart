import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class deliverProductCard extends StatelessWidget {
  final data;
  const deliverProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            height: 80,
            child: Row(
              spacing: 5,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network("http://localhost:5000/${data['imageUrl']}"),
                ),
                Column(
                  spacing:3,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("${data["name"]}", style: TextStyle(fontWeight: FontWeight.w500),),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Merhant: ${data['merchant']['firstname']}"),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Quantity: ${data['quantity']}"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(children: [Text("\$300",style:GoogleFonts.geologica( fontWeight: FontWeight.bold, fontSize: 17),), Text("\$100 each")]),
        ],
      ),
    );
  }
}
