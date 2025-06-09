import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/userreviewpage.dart';
import 'package:flutter_project/widgets/user-widgets/kioksshopitem.dart';
import 'package:google_fonts/google_fonts.dart';

class KioksPage extends StatefulWidget {
  const KioksPage({super.key});

  @override
  State<KioksPage> createState() => _KioksPageState();
}

class _KioksPageState extends State<KioksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        title: Text('Shemsu Suk', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),),
        centerTitle: true,
      ),
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (builder) => UserReviewPage()));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rating', style: GoogleFonts.poppins(),),
                            const SizedBox(height: 2,),
                            Row(
                              children: [
                                Icon(Icons.star_border, color: Colors.green,),
                                Text('5.0'),
                              ],
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text('Working Hours', style: GoogleFonts.poppins(),),
                          Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.green,),
                              const SizedBox(width: 2,),
                              Text('8:30 - 22:00'),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) => KioksShopItem(),
                      ),
              ),
            ],
          ),
        ),
    )
  );
  }
}