import 'package:flutter/material.dart';

class Deliverycard extends StatelessWidget {
  final dynamic getData;
  Deliverycard({required this.getData});
  List<dynamic> productList = [];

  @override
  Widget build(BuildContext context) {
    print("From Delivery Card: $getData");
    productList.addAll(getData['products']);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade200),
          boxShadow: [
            // BoxShadow(
            //     color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 7)
          ],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order: #${getData['orderId']}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shop,
                          color: Colors.red,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Current Pickup",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          itemCount: productList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${productList[index]['merchant']['firstname']}'s Store",
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Lat:${productList[index]['merchant']['address']['latitude']}, ",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Long:" +
                                              productList[index]['merchant']
                                                      ['address']['longitude']
                                                  .toString()),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Divider(),

                  SizedBox(
                    child:Column(
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView.builder(itemCount:productList.length,itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Text("${productList[index]['name']} from ${productList[index]['merchant']['firstname']}"),
                                  Text("\$ ${productList[index]['price'].toString()}")
                              ],
                            );
                          } ),
                        )
                      ],
                    )
                  )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

    