import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/CommentCard.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;

class UserReviewPage extends StatefulWidget {
  final id;
  const UserReviewPage({super.key, required this.id});

  @override
  State<UserReviewPage> createState() => _UserReviewPageState();
}

class _UserReviewPageState extends State<UserReviewPage> {
  List<dynamic> comments = [];
 Future<void> getComments() async {
  final url = Uri.parse('http://localhost:5000/api/comments/load/${widget.id}');
  final response = await http.get(url, headers: {"Content-Type":"application/json"});

  if(response.statusCode==200) {
      List<dynamic> commentResponse = json.decode(response.body);
      setState(() {
        comments.clear();
        comments.addAll(commentResponse);
      });
  }
 }

   @override
  void initState() {
    super.initState();
    // This for telling flutter to render components first before fetching any data from the API
    WidgetsBinding.instance.addPostFrameCallback((_) {
getComments();
      // getLocationFromIP();
    });
  }
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
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return CommentsCard(review: comments[index]);
        }),
      ),
    );
  }
}

