import 'package:flutter/material.dart';
import 'package:flutter_project/models/Product.dart';
import 'package:flutter_project/pages/user-page/checkoutpage.dart';
import 'package:flutter_project/providers/cart_provider.dart';
import 'package:flutter_project/widgets/user-widgets/cartitems.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  final String id;
  const CartPage({super.key, required this.id});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, provider,_){
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            leading: Icon(Icons.home, color: Colors.transparent,),
            backgroundColor: Colors.grey.shade50,
            title: Text(
              'CART',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child:SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: provider.items.length
                    ,scrollDirection: Axis.vertical,itemBuilder: (context, int index) {
                      Product p = provider.items[index];
                      print("Product $p",);
                    return CartItems(
                      id:p.id,
                      name:p.name,
                      price:p.price,
                                
                    );
                  }),
                )
                     
              ),
              ElevatedButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (builder) => CheckOutPage(products:provider.items, uid:widget.id)));
              }, child: Text("Go to Checkout"))
            ],
          ),
          
        ),
      );
    });
  }
}
