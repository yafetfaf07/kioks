import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutItems extends StatelessWidget {
  final String id;
  final int price;
  final String name;
  const CheckOutItems({super.key, required this.id, required this.price, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Vegetable',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'Br',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
                ),
                const SizedBox(width: 4),
                Text(
                  price.toString(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
