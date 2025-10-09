import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/delivery-widgets/delivery-card.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;

class Deliverypage extends StatefulWidget {
  final String id;
  const Deliverypage({super.key, required this.id});

  @override
  State<Deliverypage> createState() => _DeliverypageState();
}

class _DeliverypageState extends State<Deliverypage> {
  List<dynamic> getOrderData = [];

  Future<void> getOrders() async {
    final url = Uri.parse(
      "http://localhost:5000/api/order/getOrderByDeliverId/${widget.id}",
    );

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {

      print(response.body);
      List<dynamic> orderResponse = json.decode(response.body);
      setState(() {
        getOrderData.clear(); // Clear previous data to avoid duplicates
        getOrderData.addAll(orderResponse);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // This for telling flutter to render components first before fetching any data from the API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOrders();
      // getLocationFromIP();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Delivery Dashboard",
              style: GoogleFonts.geologica(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Manage your orders efficiently",
              style: GoogleFonts.geologica(fontSize: 20),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width*0.85,
              child: ListView.builder(
                itemCount: getOrderData.length,
                itemBuilder: (context, index) {
                  return Deliverycard(data:getOrderData[index], num:index+1);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
