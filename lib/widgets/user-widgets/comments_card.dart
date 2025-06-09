import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentsCard extends StatelessWidget {
  final Review review;
  const CommentsCard({super.key, required this.review});

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
                  Text(review.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index == 0 ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 18,
                      );
                    }),
                  ),
                  if (review.comment.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        review.comment,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  if (review.comment.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text("No comment", style: TextStyle(color: Colors.grey)),
                    ),
                ],
              ),),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String name;
  final String comment;

  Review({required this.name, required this.comment});
}
