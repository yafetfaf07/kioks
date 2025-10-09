// ✅ KioksShopItem (update this file)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KioksShopItem extends StatelessWidget {
  final String merchantName;
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final int price;
  final int quantity;
  final int changedQuantity;
  final VoidCallback providers;
  final bool isInCart;

  const KioksShopItem({
    super.key,
    required this.providers,
    required this.merchantName,
    required this.changedQuantity,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.quantity,
    required this.isInCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: EdgeInsets.only(right: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  'http://192.168.1.15:5000/$imageUrl',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(merchantName),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "\$$price",
                  style: GoogleFonts.geologica(color: Colors.green),
                ),
              ),
              GestureDetector(
                onTap: providers,
                child: Container(
                  width: 140,
                  margin: EdgeInsets.only(right: 12),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: !isInCart ? [Color(0xFF22c45e), Color(0XFF16a44a)] : [const Color.fromARGB(255, 236, 126, 118), const Color.fromARGB(255, 110, 35, 29)],
                    ),
                  ),
                  child: Text(
                    isInCart ? "Remove from cart" : "Add to cart",
                    style: GoogleFonts.geologica(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}