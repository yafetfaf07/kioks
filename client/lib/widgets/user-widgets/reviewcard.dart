import 'package:flutter/material.dart';

class Reviewcard extends StatelessWidget {
  final itemImagePath;
  final itemName;
  final price;
  final quantity;
  const Reviewcard({
    super.key,
    required this.itemImagePath,
    this.itemName,
    this.price,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          width: 80,
          height: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
          child: Image.network(
            "http://192.168.1.15:5000/$itemImagePath",
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '$price Br',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Text(
            'Quantity: $quantity',
            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}
