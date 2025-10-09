import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/Product.dart';
import 'package:flutter_project/pages/user-page/user-reviewPage.dart';
import 'package:flutter_project/providers/cart_provider.dart';
import 'package:flutter_project/widgets/user-widgets/kioksshopitem.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class KioksPage extends StatefulWidget {
  final String id;
  final String name;
  final String rating;

  const KioksPage({super.key, required this.id, required this.name, required this.rating});

  @override
  State<KioksPage> createState() => _KioksPageState();
}

class _KioksPageState extends State<KioksPage> {
  bool isLoading = true;
  List<Product> getProduct = [];

  Future<void> getAllProducts() async {
    final uri = Uri.parse(
      "http://192.168.1.15:5000/api/product/getProductByMerchantId/${widget.id}",
    );
    final response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      List<dynamic> productResponse = json.decode(response.body);
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
      getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            // Top banner with image and overlay
            Container(
              margin: EdgeInsets.only(bottom:5),
              child: Stack(
                children: [
                  // Background image
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/categoriesimage/merchant.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              
                  // Dark overlay
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                    width: double.infinity,
                    height: 300,
                  ),
              
                  // Foreground content
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: const Icon(Icons.chevron_left),
                                ),
                              ),
                            
                            ],
                          ),
                          const SizedBox(height: 140),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserReviewPage(id:widget.id)));
                                },child: _buildInfoColumn("Rating", Icons.star_outline, widget.rating)),
                                _buildInfoColumn("Working Hours", Icons.access_time, "08:30 - 21:50"),
                                _buildInfoColumn("Delivery Time", Icons.motorcycle, "43 min"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
              Align(alignment: Alignment.centerLeft,child: Text("List of Products", style: GoogleFonts.geologica(fontWeight: FontWeight.bold, fontSize: 18),)),
            // Product Grid
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.88,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getProduct.length,
                  // padding: const EdgeInsets.only(top: 10),
               
                  
               // ✅ KioksPage (update this part in ListView.builder)
itemBuilder: (BuildContext context, int index) {
  Product p = getProduct[index];
  bool isInCart = cartProvider.isInCart(p.id);

  void toggleCart() {
    if (isInCart) {
      cartProvider.removeProduct(p);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${p.name} removed from cart.')),
      );
    } else {
      cartProvider.addProduct(p);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${p.name} added to cart.')),
      );
    }
    setState(() {});
  }

  return KioksShopItem(
    merchantName: widget.name,
    changedQuantity: p.changedQuantity,
    id: p.id,
    name: p.name,
    category: p.category,
    price: p.price,
    quantity: p.quantity,
    imageUrl: p.imageUrl,
    providers: toggleCart,
    isInCart: isInCart,
  );
}
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for top info display
  Widget _buildInfoColumn(String title, IconData icon, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white)),
        Row(
          children: [
            Icon(icon, color: Colors.greenAccent),
            const SizedBox(width: 5),
            Text(value, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}
