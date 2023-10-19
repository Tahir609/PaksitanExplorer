import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:travelhour/data/hotels_data.dart';

import '../../../data/restraurent_data.dart';
import '../../../model/restraurent_model.dart';

class NearByRestaurant extends StatefulWidget {
  const NearByRestaurant({super.key});

  @override
  State<NearByRestaurant> createState() => _NearByRestaurant();
}

class _NearByRestaurant extends State<NearByRestaurant> {
  double latitude = rest[0].latitude;
  double longitude = rest[0].longitude;

  int currentHotelIndex = 0;
  PageController controller = PageController();
  final Completer<GoogleMapController> _controller = Completer();

  // Define a global marker set.
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();

    // Initialize the markers in the initState method.
    _markers.add(
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: rest[currentHotelIndex].hotelName),
      ),
    );
  }

  void updateCameraPosition() async {
    final GoogleMapController controller = await _controller.future;
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 14,
            ),
            markers: _markers,
            onMapCreated: (controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Container(
              height: 150,
              color: Colors.white,
              child: PageView.builder(
                onPageChanged: (value) {
                  print(value);
                  setState(() {
                    currentHotelIndex = value;
                    latitude = rest[value].latitude;
                    longitude = rest[value].longitude;
                    _markers.clear();
                    _markers.add(
                      Marker(
                        markerId: MarkerId('1'),
                        position: LatLng(latitude, longitude),
                        infoWindow: InfoWindow(
                            title: rest[currentHotelIndex].hotelName),
                      ),
                    );
                    updateCameraPosition(); // Update the camera position
                  });
                },
                itemCount: rest.length,
                controller: controller,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                    child: Row(children: [
                      Container(
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff9f9d9e))),
                        child: Image.network(
                          rest[index].imgUrl.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 180,
                              child: Text(
                                rest[index].hotelName.toString(),
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: 170,
                              child: Text(
                                rest[index].addressName.toString(),
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('⭐⭐⭐⭐⭐(4.6)')
                          ],
                        ),
                      )
                    ]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
