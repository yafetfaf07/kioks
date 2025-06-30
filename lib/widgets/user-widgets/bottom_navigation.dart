import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigation extends StatelessWidget {
  final void Function(int)? onChange;
  final int selectedIndex;

  const BottomNavigation({
    super.key,
    required this.onChange,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200, width: 3),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade50, spreadRadius: 7, blurRadius: 6)
        ]
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GNav(
        selectedIndex: selectedIndex, // ✅ this is important
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        activeColor: const Color.fromARGB(255, 71, 219, 78),
        tabActiveBorder: Border.all(color: Colors.white),  
        tabBackgroundColor: Colors.green.shade200,
        tabBorderRadius: 15,
        onTabChange: onChange,
        gap: 8,
        tabs: const [
          GButton(
            iconSize: 30,
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            iconSize: 30,
            icon: Icons.shopping_cart,
            text: "Cart",
          ),
          GButton(
            iconSize: 30,
            icon: Icons.history,
            text: "Orders",
          ),
        ],
      ),
    );
  }
}
