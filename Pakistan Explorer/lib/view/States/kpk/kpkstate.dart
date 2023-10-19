import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travelhour/data/provincedata.dart';

import '../../detailpage/detailsplace.dart';

class Kpkstate extends StatefulWidget {
  Kpkstate({super.key});

  @override
  State<Kpkstate> createState() => _Kpkstate();
}

class _Kpkstate extends State<Kpkstate> {
  final CollectionReference kpk =
      FirebaseFirestore.instanceFor(app: Firebase.app('learn'))
          .collection('khyber Pakhtunkhwa');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        leadingWidth: 100,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'khyber Pakhtunkhwa',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_sharp,
              size: 18,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: StreamBuilder(
              stream: kpk.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return AutoplayPageView(
                                documentSnapshot: documentSnapshot,
                              );
                            },
                          ));
                        },
                        child: Container(
                          height: 300,
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          documentSnapshot['img1url']),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 200,
                                left: 12,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      documentSnapshot['placename'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 18,
                                          color: Color(0xff626262),
                                        ),
                                        Text(
                                          documentSnapshot['locationname'],
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff626262)),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Icon(Icons.watch_later_outlined,
                                            size: 18, color: Color(0xff626262)),
                                        Text(
                                          '24 March 2023',
                                          style: TextStyle(
                                              color: Color(0xff626262)),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Icon(Icons.favorite_border,
                                            size: 18, color: Color(0xff626262)),
                                        Text(
                                          '23',
                                          style: TextStyle(
                                              color: Color(0xff626262)),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Icons.comment_outlined,
                                            size: 18, color: Color(0xff626262)),
                                        Text(
                                          '23',
                                          style: TextStyle(
                                              color: Color(0xff626262)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
