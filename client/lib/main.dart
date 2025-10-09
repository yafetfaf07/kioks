import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/usersignuppage.dart';
import 'package:flutter_project/providers/cart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( ChangeNotifierProvider(
    create: (context) => CartProvider(),
    child: MaterialApp(
      // theme: ThemeData(textTheme: GoogleFonts.geologicaTextTheme()),
      debugShowCheckedModeBanner: false,
      home:UserSignUppage(),
    ),
  ));
}

