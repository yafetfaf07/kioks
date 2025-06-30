import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/delivery-widgets/deliverProductCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Deliverycard extends StatelessWidget {
  final data;
  final num;
  const Deliverycard({super.key, required this.data, required this.num});

  void _launchSearch() async {
    const query = "Flutter desktop app tutorial";
    String urls =
        "https://www.google.com/maps/dir/?api=1&origin=${data["user"]['latitude']},${data['user']['longitude']}&destination=9.0192538,38.7661311&travelmode=driving";

    final url = Uri.parse(urls);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> products = data['products'];
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 10)],
      ),
      width: 500,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order #$num",
                style: GoogleFonts.geologica(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(children: [Icon(Icons.access_time), Text("June 13, 2025")]),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: const Color(0Xffeff6ff),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.person_outline, color: Colors.blue),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Customer Details",
                          style: GoogleFonts.geologica(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Name: ${data['user']['firstname']}",
                        style: GoogleFonts.geologica(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: const Color.fromARGB(255, 17, 76, 124),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone_outlined, color: Colors.blue),
                        Text('${data['user']['phone_no']}'),
                      ],
                    ),
                    SizedBox(width: 50),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: const Color(0XFF5284EF),
                      ),
                      Text("Lat: ${data['user']['address']['latitude']}, "),
                      Text("Lng: ${data['user']['address']['longitude']}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Items to Deliver (${products.length} Items)",
                style: GoogleFonts.geologica(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return deliverProductCard(data: products[index]);
              },
            ),
          ),

          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.attach_money_outlined, color: Colors.green),
                  Text(
                    "Total: \$450",
                    style: GoogleFonts.geologica(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 15,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Call Customer",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "View Map",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                    color: Colors.green,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Mark as Delivered",
                      style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
