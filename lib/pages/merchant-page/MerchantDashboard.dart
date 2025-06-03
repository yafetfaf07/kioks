import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/merchant-widgets/MerchantCard.dart';

class MerchantDashboard extends StatefulWidget {
  const MerchantDashboard({super.key});

  @override
  State<MerchantDashboard> createState() => _MerchantDashboardState();
}

class _MerchantDashboardState extends State<MerchantDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.deepPurpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Container(

              width: MediaQuery.of(context).size.width * 0.8,
              height: 500,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                
              ]),
              child: Column(
                children: [
                  Merchantcard(),
                  Merchantcard(),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      height: 80,
                      child: ListView.builder(itemCount: 5,itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Text("Hello"),
                          );
                      }),
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
