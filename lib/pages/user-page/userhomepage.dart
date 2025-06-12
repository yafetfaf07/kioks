import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/cartpage.dart';
import 'package:flutter_project/pages/user-page/categorypage.dart';
import 'package:flutter_project/pages/user-page/orderhistorypage.dart';
import 'package:flutter_project/pages/user-page/reviewpage.dart';
import 'package:flutter_project/pages/user-page/userprofilepage.dart';
//import 'package:flutter_project/pages/kiokspage.dart';
import 'package:flutter_project/widgets/user-widgets/categorycards.dart';
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

  // This is for getting users location for desktop application
  Future<void> getLocationFromIP() async {
    final response = await http.get(Uri.parse('http://ip-api.com/json/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final latitude = data['lat'];
      final longitude = data['lon'];

      // Pass this to OpenStreetMap
      print('Latitude: $latitude, Longitude: $longitude');
    } else {
      print('Failed to get location');
    }
  }

  List<dynamic> getMerchantData = [];
  Future<void> getAllMerchants(String merchants) async {
    var merchantUrl = Uri.parse(merchants);

    final response = await http.get(
      merchantUrl,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      List<dynamic> merchantResponse = json.decode(response.body);
      // print(response.body);
      setState(() {
        getMerchantData.clear(); // Clear previous data to avoid duplicates
        getMerchantData.addAll(merchantResponse);
        isFetching = false;
      });
    } else {
      // print("Error Response: ${response.body}");
    }
  }

  @override
  void initState() {
    super.initState();
    // This for telling flutter to render components first before fetching any data from the API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllMerchants("http://localhost:5000/api/merchant/getAllMerchant/");
      // getLocationFromIP();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("User id ${widget.id}");
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
                  GestureDetector(
                    child: CategoryCards(),
                    onTap: () {
                      getAllMerchants(
                        "http://localhost:5000/api/product/getProductByCategory/Fruits",
                      );
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (builder) => Categorypage()),
                      // );
                    },
                  ),
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
                      ? CircularProgressIndicator()
                      : Expanded(
                        child: ListView.builder(
                          itemCount: getMerchantData.length,
                          itemBuilder: (BuildContext context, int index) {
                            String rating;
                            if (getMerchantData[index]['overallRating'] ==
                                null) {
                              rating = 0.0.toString();
                            } else {
                              rating =
                                  getMerchantData[index]['overallRating']
                                      .toString();
                            }
                            return KioksCard(
                              id:getMerchantData[index]['_id'],
                              name: getMerchantData[index]['firstname'],
                              rating: getMerchantData[index]['overallRating']+.0,
                            );
                          },
                        ),
                      ),
                ],
              ),
              CartPage(id: widget.id,),
              OrderHistoryPage(id:widget.id),
              Reviewpage()
            ],
          ),
        ),
        bottomNavigationBar: TabBar(
          onTap: (index) {
            if (index == 0) {
              getAllMerchants(
                "http://localhost:5000/api/merchant/getAllMerchant/",
              );
            }
          },
          tabs: [
            Tab(icon: Icon(Icons.home, color: Colors.green, size: 30)),
            Tab(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.green,
                size: 30,
              ),
            ),
            Tab(icon: Icon(Icons.article, color: Colors.green, size: 30)),
            Tab(
              icon: Icon(
                Icons.account_circle_rounded,
                color: Colors.green,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
