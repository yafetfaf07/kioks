import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/cartpage.dart';
import 'package:flutter_project/pages/user-page/orderhistorypage.dart';
import 'package:flutter_project/widgets/user-widgets/bottom_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_project/widgets/user-widgets/kioks-card.dart';
import "package:http/http.dart" as http;

class UserHomepage extends StatefulWidget {
  final String id;
  const UserHomepage({super.key, required this.id});

  @override
  State<UserHomepage> createState() => _UserHomepageState();
}

class _UserHomepageState extends State<UserHomepage> {
  bool isFetching = true;
  int selectedIndex = 0;
  TextEditingController search = TextEditingController();
  List<dynamic> getMerchantData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllMerchants("http://192.168.1.15:5000/api/merchant/getAllMerchant/");
    });
  }

  // Get list of merchant cards
  Future<void> getAllMerchants(String merchants) async {
    var merchantUrl = Uri.parse(merchants);
    final response = await http.get(
      merchantUrl,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> merchantResponse = json.decode(response.body);
      setState(() {
        getMerchantData.clear();
        getMerchantData.addAll(merchantResponse);
        isFetching = false;
      });
    }
  }

  // Search merchants by name
  Future<void> getMerchantByName() async {
    final url = Uri.parse(
      "http://192.168.1.15:5000/api/merchant/findByName/${search.text}",
    );

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      List<dynamic> merchantResponse = json.decode(response.body);
      setState(() {
        getMerchantData.clear();
        getMerchantData.addAll(merchantResponse);
        isFetching = false;
      });
    }
  }

  // Pages for bottom navigation
  List<Widget> get pages => [
    _buildHomePage(),
    CartPage(id: widget.id),
    OrderHistoryPage(id: widget.id),
  ];

  // Home Page UI (first page)
  Widget _buildHomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hello, There',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.logout, color: Colors.white,),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // IconButton(onPressed: () {
            //   Navigator.of(context).pop();
            // }, icon: Icon(Icons.chevron_left)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextField(
                    controller: search,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 12, top: 11),
                      hintText: 'Search',
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          getMerchantByName();
                        },
                        child: Icon(Icons.search, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const SizedBox(height: 10),
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
            isFetching
                ? const CircularProgressIndicator()
                : SizedBox(
                  height: 300, // Set a fixed height for the horizontal ListView
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getMerchantData.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (getMerchantData.isEmpty) {
                        return Center(
                          child: const Text(
                            "No shops around you",
                            style: TextStyle(fontSize: 50, color: Colors.black),
                          ),
                        );
                      } else {
                        String rating =
                            getMerchantData[index]['overallRating']
                                ?.toString() ??
                            "No rating";
                        return KioksCard(
                          id: getMerchantData[index]['_id'],
                          name: getMerchantData[index]['firstname'],
                          rating: rating,
                        );
                      }
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }

  // Change selected tab
  void onChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: selectedIndex,
        onChange: onChange,
      ),
    );
  }
}
