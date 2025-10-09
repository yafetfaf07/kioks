import 'package:flutter/material.dart';
import 'package:flutter_project/providers/cart_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartItems extends StatefulWidget {
  final String name;
  final int price;
  final String id;

  const CartItems({
    super.key,
    required this.id,
    required this.name,
    required this.price,
  });

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    print("Name ${widget.id}");
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '1kg, ${widget.price.toString()} Br',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.green.shade400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    if (quantity > 1) {
                      setState(() {
                        quantity--;
                        cartProvider.updateQuantity(widget.id, quantity);
                      });
                    }
                  },
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.grey.shade400,
                    size: 35,
                  ),
                ),
                Text(
                  quantity.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                      cartProvider.updateQuantity(widget.id, quantity);
                    });
                  },
                  icon: Icon(
                    Icons.add_circle_rounded,
                    color: Colors.green.shade600,
                    size: 35,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
