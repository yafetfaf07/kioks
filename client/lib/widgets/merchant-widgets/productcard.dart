import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String category;
  final int price;
  final int quantity;
  final int totalRevenue;
  final int changedQuantity;
  final String id;

   ProductCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.totalRevenue,
    required this.changedQuantity
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  TextEditingController nameController = TextEditingController();

    TextEditingController quantityController = TextEditingController();

Future<void> updateProduct() async {
  // if(selectedFile==null) return;
  final url = Uri.parse("http://localhost:5000/api/product/updateProduct/${widget.id}");
final response = await http.patch(url, headers: {"Content-Type":"application/json"}, body: jsonEncode({
  "name":nameController.text,
  "changedQuantity":quantityController.text
}));
if(response.statusCode==200) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated Successfully")));
}

}

void showUpdateDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Update Product"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Important to avoid infinite height
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload a new to your inventory. Fill in all the required details"),
              SizedBox(height: 8),
              Text("Product Name"),
              TextField(
                controller: nameController,
              ),
              SizedBox(height: 8),

              Text("Quantity"),
              TextField(
                controller: quantityController,
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  updateProduct();
                },
                child: Text("Update Stock"),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    int revenue = widget.quantity * widget.price;
    return Container(
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 1),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.0),
                    ),
                  ),
                  child:
                      widget.imageUrl.isNotEmpty
                          ? ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.0),
                            ),
                            child: Image.network(
                              "http://localhost:5000/${widget.imageUrl}",
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Center(
                                    child: Icon(
                                      Icons.image_outlined,
                                      size: 60,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                            ),
                          )
                          : Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 60,
                              color: Colors.grey[400],
                            ),
                          ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: widget.changedQuantity>0 ? Colors.black : Colors.redAccent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child:
                        widget.changedQuantity>0
                            ? Text(
                              'Active',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                            : Text(
                              'Out of Stock',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.category,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
           
                  SizedBox(height: 12),

                  const Spacer(),

                  // Price and Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      Text(
                        'Remaining: ${widget.changedQuantity}',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Sold and Total Revenue
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sold: ${widget.quantity}',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        '\$${revenue.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  // Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: LinearProgressIndicator(
                      value: widget.quantity > 0 ? (widget.quantity-widget.changedQuantity) / widget.quantity : 0,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      minHeight: 7, // Reduced height
                    ),
                  ),
                  SizedBox(height: 30,),
                  // the 2 buttons
                  IntrinsicHeight(
                    // Ensures both buttons have the same height
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: OutlinedButton(
                              onPressed: () {
                                // Add navigation logic here
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: Colors.grey[900],
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'View',
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ), // Vertical divider
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: OutlinedButton(
                              onPressed: () {
                                showUpdateDialog(context);
                                // Add navigation logic here
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit_outlined,
                                    color: Colors.grey[900],
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
