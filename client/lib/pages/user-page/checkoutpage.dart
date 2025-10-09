import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/Product.dart';
import 'package:flutter_project/widgets/user-widgets/checkoutitems.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;

class CheckOutPage extends StatefulWidget {
  final List<Product> products;
  final String uid;
  const CheckOutPage({super.key, required this.products, required this.uid});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Future<void> createOrder() async {
    final productList = widget.products.map(
      (product) => {"pid": product.id, "quantity":product.cartChangeQuantity},
    ).toList();
    final url = Uri.parse("http://192.168.1.15:5000/api/order/create");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"uid": widget.uid, "product": productList}),
    );
    if(response.statusCode==201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successful")));
      print("Order created: ${response.body}");
    }
  }

  int total = 0;
  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.products.length; i++) {
      total += widget.products[i].price;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Checkout",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Products',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
          
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: widget.products.length,
                    itemBuilder: (context, index) {
                      return CheckOutItems(
                        id: widget.products[index].id,
                        name: widget.products[index].name,
                        price: widget.products[index].price,
                      );
                    },
                  ),
                ),
                // CheckOutItems(),
                // CheckOutItems(),
                // CheckOutItems(),
                const SizedBox(height: 30),
                Text(
                  'Delivered to',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'figa, wereda 08 block 7',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Payment Method',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Cash on delivery',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 60),
                Row(
                  children: [
                    Text(
                      'Subtotal',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          'Br',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "rred",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.green.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Delivery fee',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          'Br',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '15',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.green.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          'Br',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          total.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.green.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
          
                    child: ElevatedButton(
                      onPressed: () {
                        createOrder();
                      },
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 25,
                        ),
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'checkout',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
