import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class places extends StatefulWidget {
  const places({super.key});

  @override
  State<places> createState() => _placesState();
}

class _placesState extends State<places> {
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
    final CollectionReference punjab =
        FirebaseFirestore.instance.collection(selectedState.toString());
    return Container(
      width: 1300,
      margin: const EdgeInsets.only(top: 18, left: 18, right: 18),
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Places ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const Divider(
              color: Color(0xff7c4dff),
              indent: 3,
              endIndent: 1040,
              thickness: 3,
            ),
            const SizedBox(
              height: 20,
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
            StreamBuilder(
              stream: punjab.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: 1300,
                    height: 500,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: 1300,
                          padding: const EdgeInsets.all(15.0),
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xffe6e6e6),
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child:
                                    Image.network(documentSnapshot['img1url']),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      documentSnapshot['placename'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 16,
                                            ),
                                            Text(documentSnapshot[
                                                'locationname']),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.watch_later_outlined,
                                              size: 16,
                                            ),
                                            Text('24 March 20'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffeeeeee),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star_border_outlined,
                                                size: 20,
                                              ),
                                              Text('13'),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffeeeeee),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.comment,
                                                size: 20,
                                              ),
                                              Text('13'),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _update(documentSnapshot);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffeeeeee),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Icon(
                                              Icons.edit,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _showDeleteConfirmationDialog(
                                                documentSnapshot);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffeeeeee),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Icon(
                                              Icons.delete,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      [DocumentSnapshot? documentSnapshot]) async {
    final CollectionReference punjab =
        FirebaseFirestore.instance.collection(selectedState.toString());
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this this place?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                punjab.doc(documentSnapshot!.id).delete();
                Navigator.of(context).pop();
                // You can add your delete logic here
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Cancel the delete action
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      placeNameController.text = documentSnapshot['placename'];
      locationNameController.text = documentSnapshot['locationname'];
      placeLatitueController.text = documentSnapshot['placelatitude'];
      placeLongitudeController.text = documentSnapshot['placelongitude'];
      imag1UrlController.text = documentSnapshot['img1url'];
      imag2UrlController.text = documentSnapshot['img2url'];
      imag3UrlController.text = documentSnapshot['img3url'];
      placeDetailsController.text = documentSnapshot['placedetail'];
      startpointNameController.text = documentSnapshot['startpointname'];
      endPointNameController.text = documentSnapshot['endpointname'];
      startPointLatitudeController.text =
          documentSnapshot['startpointlatitude'];
      startPointLongitudeController.text =
          documentSnapshot['startpointlongitude'];
      endPointLatitudeController.text = documentSnapshot['endpointlatitude'];
      endPointLongitudeController.text = documentSnapshot['endpointlongitde'];
      priceController.text = documentSnapshot['price'];
      pathListController.text = documentSnapshot['pathlist'];
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 100,
            left: 100,
            right: 100,
            bottom: MediaQuery.of(context).viewInsets.bottom + 100,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Places Details Update',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  formField(placeNameController, TextInputType.text,
                      "Place Name", "Enter Place Name"),
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
                        child: formField(
                            endPointNameController,
                            TextInputType.text,
                            "Endpoint name",
                            "Enter endpoint name"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  formField(priceController, TextInputType.text, 'Price',
                      'Enter Price'),
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
                    height: 30,
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
                        final CollectionReference punjab = FirebaseFirestore
                            .instance
                            .collection(selectedState.toString());
                        if (pathListController.text.isNotEmpty) {
                          await punjab.doc(documentSnapshot!.id).update({
                            'placename': placeNameController.text.toString(),
                            'locationname':
                                locationNameController.text.toString(),
                            'placelatitude':
                                placeLatitueController.text.toString(),
                            'placelongitude':
                                placeLongitudeController.text.toString(),
                            'img1url': imag1UrlController.text.toString(),
                            'img2url': imag2UrlController.text.toString(),
                            'img3url': imag3UrlController.text.toString(),
                            'placedetail':
                                placeDetailsController.text.toString(),
                            'startpointname':
                                startpointNameController.text.toString(),
                            'endpointname':
                                endPointNameController.text.toString(),
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
                        'Update Place',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
