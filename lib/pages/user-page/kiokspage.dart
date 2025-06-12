import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/Product.dart';
import 'package:flutter_project/providers/cart_provider.dart';
import 'package:flutter_project/widgets/user-widgets/kioksshopitem.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class KioksPage extends StatefulWidget {
  final String id;
  final String name;

  const KioksPage({super.key, required this.id, required this.name});

  @override
  State<KioksPage> createState() => _KioksPageState();
}

class _KioksPageState extends State<KioksPage> {
  bool isLoading = true;
  List<Product> getProduct = [];
  Future<void> getAllProducts() async {
    final uri = Uri.parse(
      "http://localhost:5000/api/product/getProductByMerchantId/${widget.id}",
    );
    final response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      List<dynamic> productResponse = json.decode(response.body);
      // print("From Kioks Page $productResponse");
      setState(() {
        getProduct.clear();
        getProduct = productResponse.map((d) => Product.fromJson(d)).toList();
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error Response: ${response.body}")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllProducts(); // getLocationFromIP();
    });
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: Text(
          widget.name,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: GridView.builder(
            itemCount: getProduct.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (BuildContext context, index) {
              Product p = getProduct[index];
              void addProducts() {
                print(" Button clicked $p");
                cartProvider.addProduct(p);
              }

              return KioksShopItem(
                changedQuantity: getProduct[index].changedQuantity,
                id: getProduct[index].id,
                name: getProduct[index].name,
                category: getProduct[index].category,
                price: getProduct[index].price,
                quantity: getProduct[index].quantity,
                imageUrl: getProduct[index].imageUrl,
                providers: addProducts,
              );
            },
          ),
        ),
      ),
    );
  }
}
