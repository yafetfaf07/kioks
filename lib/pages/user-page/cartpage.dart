import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/user-widgets/cartitems.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          title: Text(
            'CART',
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              CartItems(),
              CartItems(),
              CartItems(),
              CartItems(),
              CartItems(),
            ],
          ),
        ),
      ),
    );
  }
}
