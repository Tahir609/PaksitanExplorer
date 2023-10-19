import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class uploadPlaces extends StatefulWidget {
  const uploadPlaces({super.key});

  @override
  State<uploadPlaces> createState() => _uploadPlacesState();
}

class _uploadPlacesState extends State<uploadPlaces> {
  TextEditingController placeNameController = TextEditingController();
  TextEditingController locationNameController = TextEditingController();
  TextEditingController placeLatitueController = TextEditingController();
  TextEditingController placeLongitudeController = TextEditingController();
  TextEditingController imag1UrlController = TextEditingController();
  TextEditingController imag2UrlController = TextEditingController();
  TextEditingController imag3UrlController = TextEditingController();
  TextEditingController placeDetailsController = TextEditingController();
  TextEditingController startpointNameController = TextEditingController();
  TextEditingController endPointNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController startPointLatitudeController = TextEditingController();
  TextEditingController startPointLongitudeController = TextEditingController();
  TextEditingController endPointLatitudeController = TextEditingController();
  TextEditingController endPointLongitudeController = TextEditingController();
  TextEditingController pathListController = TextEditingController();

  static List<String> statesName = [
    'punjab',
    'khyber Pakhtunkhwa',
    'balochistan',
    'sindh',
    'kashmir',
    'gilgit-Baltistan'
  ];
  String? selectedState;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 1000,
        margin: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Places Details',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color(0xffeeeeee),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: selectedState,
                    hint: const Text('Please Select Province'),
                    onChanged: (value) {
                      setState(() {
                        selectedState = value;
                      });
                    },
                    items: statesName.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              formField(placeNameController, TextInputType.text, "Place Name",
                  "Enter Place Name"),
              const SizedBox(
                height: 20,
              ),
              formField(locationNameController, TextInputType.text,
                  "Location Name", "Enter Location Name"),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: formField(placeLatitueController,
                        TextInputType.number, "Latitude", "Enter Latitude"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: formField(placeLongitudeController,
                        TextInputType.text, "Longitude", "Enter Longitude"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              formField(
                imag1UrlController,
                TextInputType.text,
                "Image1 (Thumbnail)",
                "Enter image url (Thumbnail)",
              ),
              const SizedBox(
                height: 20,
              ),
              formField(
                imag2UrlController,
                TextInputType.text,
                "Image 2",
                "Enter image url",
              ),
              const SizedBox(
                height: 20,
              ),
              formField(
                imag3UrlController,
                TextInputType.text,
                "Image 3",
                "Enter image url",
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 6,
                controller: placeDetailsController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('Place Details'),
                  hintText: "Enter Place Details",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Travel Guide Details',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: formField(
                        startpointNameController,
                        TextInputType.number,
                        "Startpoint name",
                        "Enter startpoint name"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: formField(endPointNameController, TextInputType.text,
                        "Endpoint name", "Enter endpoint name"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              formField(
                  priceController, TextInputType.text, 'Price', 'Enter Price'),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: formField(
                        startPointLatitudeController,
                        TextInputType.number,
                        "Startpoint latitude",
                        "Enter startpoint latitude"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: formField(
                        startPointLongitudeController,
                        TextInputType.text,
                        "Starpoint longitude",
                        "Enter starpoint longitude"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: formField(
                        endPointLatitudeController,
                        TextInputType.number,
                        "Endpoint latitude",
                        "Enter startpoint latitude"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: formField(
                        endPointLongitudeController,
                        TextInputType.text,
                        "Endpoint longitude",
                        "Enter endpoin longitude"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              formField(pathListController, TextInputType.text, 'Path List',
                  'Enter path list that'),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 900,
                height: 50,
                color: const Color(0xff7c4dff),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(
                        0xff7c4dff,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    String path = pathListController.text;
                    if (path.isNotEmpty) {
                      final CollectionReference state = FirebaseFirestore
                          .instance
                          .collection(selectedState.toString());
                      await state.add({
                        'placename': placeNameController.text.toString(),
                        'locationname': locationNameController.text.toString(),
                        'placelatitude': placeLatitueController.text.toString(),
                        'placelongitude':
                            placeLongitudeController.text.toString(),
                        'img1url': imag1UrlController.text.toString(),
                        'img2url': imag2UrlController.text.toString(),
                        'img3url': imag3UrlController.text.toString(),
                        'placedetail': placeDetailsController.text.toString(),
                        'startpointname':
                            startpointNameController.text.toString(),
                        'endpointname': endPointNameController.text.toString(),
                        'price': priceController.text.toString(),
                        'startpointlatitude':
                            startPointLatitudeController.text.toString(),
                        'startpointlongitude':
                            startPointLongitudeController.text.toString(),
                        'endpointlatitude':
                            endPointLatitudeController.text.toString(),
                        'endpointlongitde':
                            endPointLongitudeController.text.toString(),
                        'pathlist': pathListController.text.toString(),
                      });
                    }
                  },
                  child: const Text(
                    'Upload Place Data',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  formField(TextEditingController controller, TextInputType textInputType,
      String labelname, String hint) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
          label: Text(labelname), hintText: hint, border: OutlineInputBorder()),
    );
  }
}
