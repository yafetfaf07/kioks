import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String category;
  final int price;
  final int quantity;
  final int totalRevenue;
  final int changedQuantity;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.totalRevenue,
    required this.changedQuantity
  });

  @override
  Widget build(BuildContext context) {
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
                      imageUrl.isNotEmpty
                          ? ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.0),
                            ),
                            child: Image.network(
                              "http://localhost:5000/$imageUrl",
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
                      color: changedQuantity>0 ? Colors.black : Colors.redAccent,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child:
                        changedQuantity>0
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
                    name,
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
                    category,
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
                        '\$${price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      Text(
                        'Qty: ${quantity - changedQuantity}',
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
                        'Sold: $changedQuantity',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Text(
                        '\$${totalRevenue.toStringAsFixed(2)}',
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
                      value: quantity > 0 ? changedQuantity / quantity : 0,
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
