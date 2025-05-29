import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
    )
  );
  }
}