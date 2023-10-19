import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TravelGuide extends StatefulWidget {
  DocumentSnapshot? documentSnapshot;
  TravelGuide({super.key, required this.documentSnapshot});
  @override
  State<TravelGuide> createState() => _TravelGuideState();
}

class _TravelGuideState extends State<TravelGuide> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    double lat = double.parse(widget.documentSnapshot!['placelatitude']);
    double long = double.parse(widget.documentSnapshot!['placelongitude']);
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 11,
    );
    final List<Marker> _markers = [
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: widget.documentSnapshot!['locationname']),
      ),
    ];
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        parallaxOffset: .5,
        minHeight: MediaQuery.of(context).size.height * 0.21,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        body: GoogleMap(
          initialCameraPosition: cameraPosition,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (controller) {
            _controller.complete(controller);
          },
        ),
        panelBuilder: (controller) => PanelWidget(
          controller: controller,
        ),
      ),
    );
  }
}

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      children: [
        Column(
          children: [
            Container(
              height: 6,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 211, 210, 210),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Travel Guide',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              text: const TextSpan(
                  text: "Estimated Cost = ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: "\$70",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ]),
            ),
            RichText(
              text: const TextSpan(
                  text: "Distance = ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: "30.02 km",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ]),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Color(0xff4e88f3),
              indent: 95,
              endIndent: 95,
              thickness: 3,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Steps',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Color(0xff4e88f3),
                endIndent: 260,
                thickness: 3,
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff438afe)),
                child: Text(
                  '1',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 10, bottom: 10, top: 10),
                child: Text(
                  'Exit Allama Iqbal International Airport (LHE).',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffffab40)),
                child: Text(
                  '2',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 10, bottom: 10, top: 10),
                child: Text(
                    'Take a taxi or a ride-sharing service to the Badshahi Mosque.',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffff4181)),
                child: Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 10, bottom: 10, top: 10),
                child: Text(
                    'Inform the driver of your destination, which is the "Badshahi Mosque" near the Lahore Fort.',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffe040fc)),
                child: Text(
                  '4',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 10, bottom: 10, top: 10),
                child: Text('Enjoy your visit to the Badshahi Mosque.',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
