import 'package:flutter/material.dart';
import 'package:flutter_project/pages/merchant-page/MerchantDashboard.dart';
import 'package:flutter_project/pages/user-page/usersignuppage.dart';
import 'package:flutter_project/providers/cart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( ChangeNotifierProvider(
    create: (context) => CartProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MerchantDashboard(),
    ),
  ));
}

