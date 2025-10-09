import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/kiokspage.dart';
import 'package:google_fonts/google_fonts.dart';

class KioksCard extends StatelessWidget {
  final String id;
  final String name;
  final String rating;
  const KioksCard({
    super.key,
    required this.id,
    required this.name,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => KioksPage(id: id, name: name, rating:rating),
          ),
        );
      },
      child: Container(
        width: 300,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/categoriesimage/merchant.jpg',
                  width: 300,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Icon(Icons.star_rate_rounded, color: const Color.fromARGB(255, 255, 193, 59)),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0,left: 8.0 ),
                        child: Text(rating, style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.location_on_outlined, color: Colors.grey,),
                        ),
                        Text("0.8 km away", style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.grey,),
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Text("Around 20 min", style: TextStyle(color: Colors.grey),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
