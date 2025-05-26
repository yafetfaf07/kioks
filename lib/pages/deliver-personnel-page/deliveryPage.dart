import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_project/widgets/delivery-widgets/delivery-card.dart';
import 'package:latlong2/latlong.dart';
import "package:http/http.dart" as http;

class Deliverpage extends StatefulWidget {
  const Deliverpage({super.key});

  @override
  State<Deliverpage> createState() => _DeliverpageState();
}

class _DeliverpageState extends State<Deliverpage> {
  final List<dynamic> _getData = [];
   bool isLoading=true;
   String message="";
// Get order By Deliver Id

  Future<void> getOrder() async {
    final url = Uri.parse(
        "http://localhost:5000/api/order/getOrderByDeliverId/68306be05ba15e1a12b52d34");

    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      setState(() {
        _getData.clear();
      _getData.addAll(json.decode(response.body));
      isLoading=false;
        
      });
    }
    else {
      setState(() {
        message="Failed";
        isLoading=false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            height: 320,
            child: FlutterMap(
              options: MapOptions(
                  initialCenter: LatLng(9.035883, 38.7619164),
                  initialZoom: 30,
                  interactionOptions: const InteractionOptions(
                      flags: ~InteractiveFlag.doubleTapZoom)),
              children: [
                openStreetMapTileLayers,
                MarkerLayer(markers: [
                  Marker(
                      point: LatLng(
                        9.0379258,
                        38.7641349,
                      ),
                      child: Icon(
                        size: 20,
                        Icons.location_pin,
                        color: Colors.red,
                      ))
                ])
              ],
            ),
          ),
        ),
        isLoading? CircularProgressIndicator() :
        SizedBox(
          height: 400,
          width: MediaQuery.of(context).size.width*0.6,
          child: ListView.builder(
              itemCount: _getData.length,
              itemBuilder: (BuildContext context, int index) {
                return Deliverycard(
                  getData: _getData[index],
                );
              }),
        ),
      ],
    ));
  }
}

TileLayer get openStreetMapTileLayers => TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      userAgentPackageName: "dev.fleaflet.flutter_map.example",
    );