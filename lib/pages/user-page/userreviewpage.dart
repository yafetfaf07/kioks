import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/user-widgets/comments_card.dart';
import 'package:google_fonts/google_fonts.dart';

class UserReviewPage extends StatefulWidget {
  const UserReviewPage({super.key});

  @override
  State<UserReviewPage> createState() => _UserReviewPageState();
}

class _UserReviewPageState extends State<UserReviewPage> {
    final List<Review> reviews = [
    Review(name: "Vithun", comment: "The worst one I had ever I order from beu delivery"),
    Review(name: "bruck", comment: ""),
    Review(name: "SarA", comment: "The broccoli 🥦 wasn't cooked it was raw ,I don't like it 😔"),
    Review(name: "Hode", comment: "The beef is not fresh at all. Almost going bad. same thing happened with my previous order of mixed noodle fish testing terrible"),
    Review(name: "bruck", comment: ""),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Kioks Review', style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child:  ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return CommentsCard(review: reviews[index]);
        }),
      ),
    );
  }
}


