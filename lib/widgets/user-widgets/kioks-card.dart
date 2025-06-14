import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/kiokspage.dart';
import 'package:google_fonts/google_fonts.dart';

class KioksCard extends StatelessWidget {
final String id;
final String name;
final String rating;
  const   KioksCard({super.key, required this.id, required this.name, required this.rating});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (builder) => KioksPage(id: id,name: name,)));
      },
      child: Card(
        // width: double.infinity,
        // height: 120,
        // decoration: BoxDecoration(
        //   border: Border.all(width: 10, color: Colors.grey.shade100),
        //   borderRadius: BorderRadius.circular(15),
        // ),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Image.asset(
                'assets/categoriesimage/bakery.png',
                width: 110,
                height: 110,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 100,),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange.shade500,),
                        Text(rating.toString()),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
      
                      height: 30,
                      width: 125,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.green.shade600,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Around 1Km away',
                          style: TextStyle(
                            color: Colors.green.shade600,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.green.shade600,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Around 42min',
                          style: TextStyle(
                            color: Colors.green.shade600,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text('Delivery Fee Starting from 20birr', style: TextStyle(color: Colors.grey),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
