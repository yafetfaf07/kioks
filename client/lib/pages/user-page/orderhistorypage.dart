import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/user-widgets/orderitem.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;

class OrderHistoryPage extends StatefulWidget {
  final String id;
  const OrderHistoryPage({super.key, required this.id});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
List<dynamic> getOrderByUserId = [];
Future<void> getOrder() async {
  final uri= Uri.parse("http://192.168.1.15:5000/api/order/getOrderByUserId/${widget.id}");
  final response = await http.get(uri, headers: {"Content-Type":'application/json'});

  if(response.statusCode==200) {
    List<dynamic> orderResponse = json.decode(response.body);

    setState(() {
      getOrderByUserId.clear();
      getOrderByUserId.addAll(orderResponse);

    });
  }
  else if(response.statusCode==404) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.body)));
  }
}

  @override
  void initState() {
    super.initState();
    // This for telling flutter to render components first before fetching any data from the API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOrder();
      // getLocationFromIP();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.home, color: Colors.transparent,),
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
          child:ListView.builder(itemCount: getOrderByUserId.length,itemBuilder: (context ,index) {
              return OrderItem(merchantId:getOrderByUserId[index]['merchant']['_id'],merchantName:getOrderByUserId[index]['merchant']['firstname'], date:getOrderByUserId[index]['createdAt'], items:getOrderByUserId[index]['products'], userId:widget.id);
          })
        ),
      ),
    );
  }
}
