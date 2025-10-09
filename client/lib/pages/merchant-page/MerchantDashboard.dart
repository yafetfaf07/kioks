import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/Product.dart';
import 'package:flutter_project/widgets/merchant-widgets/productcard.dart';
import 'package:flutter_project/widgets/merchant-widgets/MerchantCard.dart';
import "package:http/http.dart" as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class MerchantDashboard extends StatefulWidget {
  final id;
  const MerchantDashboard({super.key, required this.id});

  @override
  State<MerchantDashboard> createState() => _MerchantDashboardState();
}

class _MerchantDashboardState extends State<MerchantDashboard> {
late File selectedFile;

// This is for picking files
Future<void> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if(result!=null && result.files.single.path!=null) {
    setState(() {
      selectedFile=File(result.files.single.path!);
    });
  }
}

Future<void> uploadProduct() async {
  // if(selectedFile==null) return;
  final url = Uri.parse("http://localhost:5000/api/product/create/${widget.id}");
  var request = http.MultipartRequest("POST", url);
  final mimeType =
        lookupMimeType(selectedFile!.path) ?? 'application/octet-stream';
    final mimeParts = mimeType.split('/');


     request.files.add(
      await http.MultipartFile.fromPath(
        'file', // Change this if your API expects a different field name
        selectedFile!.path,
        contentType: MediaType(mimeParts[0], mimeParts[1]),
      ),
    );

      request.fields['name'] = name.text;
    request.fields['price'] = price.text;
    request.fields['category'] = optionCategory;
    request.fields['quantity'] = "0";
    request.fields['changedQuantity']=quantity.text;
    
    var response = await request.send();

    if(response.statusCode==201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Product Uploaded Successfully")));
    }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${response.statusCode}")));
      }

}


List<Product> getProducts=[];

// Gets all products
Future<void> getAllProductsByMerchantId() async {
  final url = Uri.parse("http://localhost:5000/api/product/getProductByMerchantId/${widget.id}");
  final response = await http.get(url, headers: {"Content-Type":"application/json"});

  if(response.statusCode==200) {
    List<dynamic> productResponse = json.decode(response.body);
    setState(() {
      getProducts.clear();
      getProducts=productResponse.map((d) => Product.fromJson(d)).toList();
    });
  }
  else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error Response: ${response.body}")));
  }
}
// Find Product By name
Future<void> getProductByName() async {
  final url = Uri.parse("http://localhost:5000/api/product/getProductByName/${widget.id}/${search.text}");
  final response = await http.get(url, headers: {"Content-Type":'application/json'});
  if(response.statusCode==200) {
    List<dynamic> productResponse = json.decode(response.body);
    setState(() {
      getProducts.clear();
      getProducts=productResponse.map((d) => Product.fromJson(d)).toList();
    });
  }
}

  String optionCategory="";
  TextEditingController name = TextEditingController();
    TextEditingController price = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController search = TextEditingController();

void showDialogs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      List<String> options = ['Supermarket', 'Mini-market', 'Market'];
      return AlertDialog(
        title: Text("Add New Product"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Important to avoid infinite height
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Upload a new to your inventory. Fill in all the required details"),
              SizedBox(height: 8),
              Text("Product Name"),
              TextField(
                controller: name,
              ),
              SizedBox(height: 8),
              Text("Category"),
              DropdownButton(items:options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(), onChanged: (String? newValue) {
            setState(() {
              optionCategory = newValue!;
            });
          },),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Price (\$) "),
                        TextField(
                          controller: price,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantity"),
                        TextField(
                          controller: quantity,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  pickFile();
                },
                child: Text("Upload Product Image"),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  uploadProduct();
                },
                child: Text("Add Product"),
              ),
            ],
          ),
        ),
      );
    },
  );
}



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllProductsByMerchantId(); // getLocationFromIP();
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalSold=0;
    int totalRevenue=0;
    for(int i=0; i<getProducts.length; i++) {
      totalSold+=(getProducts[i].quantity);
      totalRevenue+=(getProducts[i].quantity) * getProducts[i].price;
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ), // Padding around the stat cards row
                  child: Row(
                    children:  [
                      MerchantCard(
                        title: 'Total Products',
                        value: '${getProducts.length}',
                        icon: Icons.inventory_2_outlined,
                      ),
                      MerchantCard(
                        title: 'Total Sold',
                        value: '$totalSold',
                        icon: Icons.shopping_cart_outlined,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ), // Padding around the stat cards row
                  child: Row(
                    children:  [
                      MerchantCard(
                        title: 'Total Revenue',
                        value: '\$ $totalRevenue',
                        icon: Icons.attach_money,
                      ),
                      // MerchantCard(
                      //   title: 'Avg. Order Value',
                      //   value: '\$31.54',
                      //   trend: '+2% from last month',
                      //   icon: Icons.ssid_chart, // Or a similar trend icon
                      // ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Products',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Manage your product inventory and track sales performance',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 400,
                              child: TextField(
                                controller: search,
                                decoration: InputDecoration(
                                  hintText: 'Search products...',
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      getProductByName();
                                    },
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 10,
                                  ), // Adjust padding
                                ),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            IconButton(onPressed: () {
                                    getAllProductsByMerchantId(); // getLocationFromIP();

                            }, icon: Icon(Icons.replay_outlined)),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors
                                                .black, // Dark background for selected
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.apps,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          // Handle grid view toggle
                                        },
                                        tooltip: 'Grid View',
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors
                                                .grey[200], // grey background for non-selected
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.view_list,
                                          color: Colors.grey[700],
                                        ), // List icon
                                        onPressed: () {
                                          // Handle list view toggle
                                        },
                                        tooltip: 'List View',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                showDialogs(context);
                                // Handle add product action
                              },
                              icon: Icon(Icons.add, color: Colors.white),
                              label: Text(
                                'Add Product',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(18.0),
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      getProducts.isNotEmpty ?
                      GridView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: getProducts.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          int revenue =  (getProducts[index].quantity-getProducts[index].changedQuantity) *getProducts[index].price;
                          return ProductCard(
                            id:getProducts[index].id,
                            changedQuantity:getProducts[index].changedQuantity,
                            totalRevenue: revenue,
                            imageUrl: getProducts[index].imageUrl,
                            name: getProducts[index].name,
                            category: getProducts[index].category,
                            price:getProducts[index].price,
                            quantity:getProducts[index].quantity,
                          );
                        },
                      ): Text("No Products found"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
