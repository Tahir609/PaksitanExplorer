import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travelhour/data/pageviewdata.dart';
import 'package:travelhour/view/Home/components/places/recentyladdedplaces/detailsrecentlyaddplaces.dart';
import 'package:travelhour/view/detailpage/detailsplace.dart';

import '../../../../../data/popularplacesdata.dart';
import '../popularplaces/detailpopularplaces.dart';

class RecentlyPlaces extends StatelessWidget {
  RecentlyPlaces({super.key});

  final CollectionReference papulor =
      FirebaseFirestore.instanceFor(app: Firebase.app('learn'))
          .collection('recent');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recently Added',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const DetailsRecentlyPlaces();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_forward,
                size: 30,
              ),
            )
          ],
        ),
        Container(
            height: 230,
            child: StreamBuilder(
              stream: papulor.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
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
                          width: 140,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(documentSnapshot['img1url']),
                                fit: BoxFit.cover),
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 20,
                                right: 10,
                                child: Container(
                                  height: 30,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff8b90a3)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.favorite_border,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '150',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 10,
                                child: Text(
                                  documentSnapshot['placename'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(''),
                  );
                }
              },
            ))
      ],
    );
  }
}
