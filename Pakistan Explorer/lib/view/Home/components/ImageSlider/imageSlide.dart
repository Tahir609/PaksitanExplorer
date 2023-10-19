import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../../../data/pageviewdata.dart';
import '../../../detailpage/detailsplace.dart';

class ImagePageView extends StatefulWidget {
  const ImagePageView({super.key});

  @override
  State<ImagePageView> createState() => _ImagePageViewState();
}

class _ImagePageViewState extends State<ImagePageView> {
  PageController pageController = PageController(viewportFraction: 1);
  double currPageValue = 0.0;
  final CollectionReference slider =
      FirebaseFirestore.instanceFor(app: Firebase.app('learn'))
          .collection('slider');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "tag-1",
          child: Container(
            height: 250,
            // color: Colors.red,
            child: StreamBuilder(
              stream: slider.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return PageView.builder(
                    controller: pageController,
                    itemCount: listPageViewData.length,
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
                        child: Stack(
                          children: [
                            Container(
                              height: 213,
                              margin: const EdgeInsets.only(right: 5, left: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    documentSnapshot['img1url'],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedContainer(
                                duration: Duration(seconds: 3),
                                curve: Curves.fastOutSlowIn,
                                margin: const EdgeInsets.only(
                                    left: 40, right: 40, bottom: 8),
                                height: 115,
                                decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 7,
                                      offset: const Offset(-5, 0),
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        documentSnapshot['placename'],
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 16,
                                            color: Color(0xffa4a4a4),
                                          ),
                                          Text(
                                            documentSnapshot['locationname'],
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      const Divider(),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.favorite_outline,
                                                size: 20,
                                                color: Color(0xffeeb25a),
                                              ),
                                              Text(listPageViewData[index]
                                                  .like
                                                  .toString())
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.comment,
                                                size: 20,
                                                color: Color(0xffeeb25a),
                                              ),
                                              Text(listPageViewData[index]
                                                  .commnet
                                                  .toString())
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
        ),
        DotsIndicator(
          dotsCount: listPageViewData.length,
          position: currPageValue.toInt(),
          decorator: DotsDecorator(
            size: const Size.square(7.0),
            activeSize: const Size(30.0, 5.0),
            activeColor: Colors.black,
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),
      ],
    );
  }
}
