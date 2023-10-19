import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travelhour/view/States/gilgit/gilgitstate.dart';
import 'package:travelhour/view/States/kpk/kpkstate.dart';
import 'package:travelhour/view/detailpage/detailsplace.dart';

import '../../../../States/punjab/detailsaboutstate.dart';

class PlacesInKpk extends StatelessWidget {
  PlacesInKpk({super.key});
  final CollectionReference gilgit =
      FirebaseFirestore.instanceFor(app: Firebase.app('learn'))
          .collection('khyber Pakhtunkhwa');
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 237,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Places in Kpk',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return Kpkstate();
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 30,
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder(
              stream: gilgit.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AutoplayPageView(
                                  documentSnapshot: documentSnapshot);
                            },
                          ));
                        },
                        child: Container(
                          // color: Colors.red,
                          height: 190,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 16),
                                  child: Container(
                                    width: double.infinity,
                                    height: 135,
                                    color: Color(0xffeeeeee),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 80),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            documentSnapshot['placename'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 18,
                                                color: Color(0xff8c8c8c),
                                              ),
                                              Text(
                                                documentSnapshot[
                                                    'locationname'],
                                                style: TextStyle(
                                                    color: Color(0xff8c8c8c),
                                                    fontSize: 8),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Divider(
                                            color: Colors.blue,
                                            endIndent: 80,
                                            indent: 43,
                                            thickness: 2,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.favorite_border,
                                                size: 18,
                                              ),
                                              Text('96'),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Icon(
                                                Icons.comment_outlined,
                                                size: 18,
                                              ),
                                              Text('23'),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            documentSnapshot['img1url'])),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
