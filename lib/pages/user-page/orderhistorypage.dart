import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/user-widgets/orderitem.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Orders',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
      
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              OrderItem(), 
              OrderItem(), 
              OrderItem(), 
              OrderItem()],
          ),
        ),
      ),
    );
  }
}
