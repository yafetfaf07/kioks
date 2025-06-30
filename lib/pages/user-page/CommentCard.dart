import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentsCard extends StatelessWidget {
  final String comment;
  final int rating;
  const CommentsCard({super.key, required this.comment, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 25,
              child: Icon(Icons.person, color: Colors.green.shade400,),
              ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment, style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                  Row(
                    children: List.generate(rating, (index) {
                      return Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 18,
                      );
                    }),
                  ),
                ],
              ),),
          ],
        ),
      ),
    );
  }
}

