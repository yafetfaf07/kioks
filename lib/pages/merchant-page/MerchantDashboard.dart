import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/merchant-widgets/productcard.dart';
import 'package:flutter_project/widgets/merchant-widgets/MerchantCard.dart';

class MerchantDashboard extends StatefulWidget {
  const MerchantDashboard({super.key});

  @override
  State<MerchantDashboard> createState() => _MerchantDashboardState();
}

class _MerchantDashboardState extends State<MerchantDashboard> {
  //exmaple list of products from server
  List products = [
    {
      "imageUrl": 'assets/categoriesimage/headphones.jpg',
      "name": "Wireless headphones",
      "category": "Electronics",
      "description": "High-quality wireless headphones with noise cancellation",
      "price": 99.99,
      "quantity": 45,
      "sold": 23,
      "totalRevenue": 2299.77,
      "isActive": false,
    },
    {
      "imageUrl": 'assets/categoriesimage/tshirt.png',
      "name": "tshirt",
      "category": "clothes",
      "description": "High-quality cotton tshirt",
      "price": 5.99,
      "quantity": 450,
      "sold": 23,
      "totalRevenue": 2299.77,
      "isActive": true,
    },
    {
      "imageUrl": 'assets/categoriesimage/headphones.jpg',
      "name": "headphones",
      "category": "Electronics",
      "description": "High-quality wireless headphones with noise cancellation",
      "price": 99.99,
      "quantity": 45,
      "sold": 23,
      "totalRevenue": 2299.77,
      "isActive": true,
    },
    {
      "imageUrl": 'assets/categoriesimage/tshirt.png',
      "name": "tshirt",
      "category": "clothes",
      "description": "High-quality cotton tshirt",
      "price": 5.99,
      "quantity": 450,
      "sold": 23,
      "totalRevenue": 2299.77,
      "isActive": true,
    },
    {
      "imageUrl": 'assets/categoriesimage/headphones.jpg',
      "name": "headphones",
      "category": "Electronics",
      "description": "High-quality wireless headphones with noise cancellation",
      "price": 99.99,
      "quantity": 45,
      "sold": 23,
      "totalRevenue": 2299.77,
      "isActive": true,
    },
    {
      "imageUrl": 'assets/categoriesimage/tshirt.png',
      "name": "tshirt",
      "category": "clothes",
      "description": "High-quality cotton tshirt",
      "price": 5.99,
      "quantity": 450,
      "sold": 23,
      "totalRevenue": 2299.77,
      "isActive": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: Text(
          "Merchant Dasboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey.shade300),
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(child: Icon(Icons.person_outline)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ), // Padding around the stat cards row
                  child: Row(
                    children: const [
                      MerchantCard(
                        title: 'Total Products',
                        value: '6',
                        trend: '0 low stock items',
                        icon: Icons.inventory_2_outlined,
                      ),
                      MerchantCard(
                        title: 'Total Sold',
                        value: '357',
                        trend: '+12% from last month',
                        icon: Icons.shopping_cart_outlined,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ), // Padding around the stat cards row
                  child: Row(
                    children: const [
                      MerchantCard(
                        title: 'Total Revenue',
                        value: '\$11259.43',
                        trend: '+8% from last month',
                        icon: Icons.attach_money,
                      ),
                      MerchantCard(
                        title: 'Avg. Order Value',
                        value: '\$31.54',
                        trend: '+2% from last month',
                        icon: Icons.ssid_chart, // Or a similar trend icon
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Products',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Manage your product inventory and track sales performance',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 400,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search products...',
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey[600],
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 10,
                                  ), // Adjust padding
                                ),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors
                                                .black, // Dark background for selected
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.apps,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          // Handle grid view toggle
                                        },
                                        tooltip: 'Grid View',
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors
                                                .grey[200], // grey background for non-selected
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.view_list,
                                          color: Colors.grey[700],
                                        ), // List icon
                                        onPressed: () {
                                          // Handle list view toggle
                                        },
                                        tooltip: 'List View',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Handle add product action
                              },
                              icon: Icon(Icons.add, color: Colors.white),
                              label: Text(
                                'Add Product',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(18.0),
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: products.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            imageUrl: products[index]["imageUrl"],
                            name: products[index]["name"],
                            category: products[index]["category"],
                            description: products[index]["description"],
                            price: products[index]["price"],
                            quantity: products[index]["quantity"],
                            sold: products[index]["sold"],
                            totalRevenue: products[index]["totalRevenue"],
                            isActive: products[index]["isActive"],
                          );
                        },
                      ),
                    ],
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
