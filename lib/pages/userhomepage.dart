import 'package:flutter/material.dart';
import 'package:flutter_project/pages/cartpage.dart';
import 'package:flutter_project/pages/orderhistorypage.dart';
import 'package:flutter_project/pages/userprofilepage.dart';
//import 'package:flutter_project/pages/kiokspage.dart';
import 'package:flutter_project/widgets/categorycards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project/widgets/kioks.dart';

class UserHomepage extends StatefulWidget {
  const UserHomepage({super.key});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: TabBarView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Hello,Nathan',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,

                          icon: Icon(Icons.search, color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Categories',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CategoryCards(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'All kioks near you',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        KioksCard(),
                        KioksCard(),
                        KioksCard(),
                        KioksCard(),
                        KioksCard(),
                        KioksCard(),
                      ],
                    ),
                  ),
                ],
              ),
              CartPage(),
              OrderHistoryPage(),
              UserProfilePage(),
            ],
          ),
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home, color: Colors.green, size: 30,)),
            Tab(icon: Icon(Icons.shopping_cart_outlined, color: Colors.green, size: 30,)),
            Tab(icon: Icon(Icons.article, color: Colors.green, size: 30,),),
            Tab(icon: Icon(Icons.account_circle_rounded, color: Colors.green, size: 30,),)
          ],
        ),
      ),
    );
  }
}
