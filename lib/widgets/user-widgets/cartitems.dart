import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( 
      margin:EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
                  'Red onions',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '1kg, 45Br',
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
                  onPressed: () {},
                  icon: Icon(Icons.remove_circle, color: Colors.grey.shade400, size: 35,),
                ),
                Text(
                  '2',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add_circle_rounded, color: Colors.green.shade600, size: 35,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
