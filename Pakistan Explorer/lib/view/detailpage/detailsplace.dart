import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:travelhour/data/pageviewdata.dart';
import 'package:travelhour/data/saveplace_data.dart';
import 'package:travelhour/view/Saved/saved.dart';
import 'package:travelhour/view/detailpage/Nearby%20Hotels/nearbyhotels.dart';
import 'package:travelhour/view/detailpage/Travel%20guide/travelguide.dart';
import 'package:travelhour/view/detailpage/Users%20Reviews/userreviews.dart';

import '../../model/savedplace_model.dart';
import 'Nearby Restaurant/nearbyrestaurant.dart';

class AutoplayPageView extends StatefulWidget {
  DocumentSnapshot? documentSnapshot;
  AutoplayPageView({super.key, required this.documentSnapshot});
  late int indexPage;
  @override
  _AutoplayPageViewState createState() => _AutoplayPageViewState();
}

class _AutoplayPageViewState extends State<AutoplayPageView> {
  String text = "";
  bool isSelected = false;
  bool isSelected2 = false;
  final int _numPages = 3;
  final int _delayMilliseconds = 3000;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  Timer? _timer; // Timer for autoplay

  @override
  void initState() {
    super.initState();
    _startAutoplay();
  }

  @override
  void dispose() {
    _stopAutoplay();
    super.dispose();
  }

  void _startAutoplay() {
    _timer = Timer.periodic(Duration(milliseconds: _delayMilliseconds),
        (Timer timer) {
      final int nextPage = (_currentPage + 1) % _numPages;
      _pageController.animateToPage(nextPage,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void _stopAutoplay() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    List<String> img = [
      widget.documentSnapshot!['img1url'].toString(),
      widget.documentSnapshot!['img2url'].toString(),
      widget.documentSnapshot!['img3url'].toString()
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PageView Slider Image
            SizedBox(
              height: 320,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: img.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(img[index]),
                          ),
                        ),
                      );
                    },
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                  ),
                  const Positioned(
                    left: 13,
                    top: 50,
                    child: CircleAvatar(
                      child: BackButton(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: DotsIndicator(
                        dotsCount: 3,
                        position: _currentPage,
                        decorator: const DotsDecorator(
                            color: Colors.white,
                            size: Size.square(5.0),
                            activeSize: Size(10.0, 10.0),
                            activeColor: Colors.white,
                            activeShape: CircleBorder()),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 30,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xff9e9e9e),
                        size: 20,
                      ),
                      Text(
                        widget.documentSnapshot!['locationname'],
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isSelected = !isSelected;
                          });
                        },
                        icon: isSelected
                            ? const Icon(
                                Icons.favorite,
                                size: 30,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                size: 30,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isSelected2 = !isSelected2;
                            if (isSelected2) {
                              savedplaces.add(SavedPlace(
                                  snapshot: widget.documentSnapshot!));
                            }
                          });
                        },
                        icon: isSelected2
                            ? const Icon(
                                Icons.bookmark,
                                size: 30,
                              )
                            : const Icon(
                                Icons.bookmark_outline,
                                size: 30,
                              ),
                      ),
                    ],
                  ),
                  Text(
                    widget.documentSnapshot!['placename'],
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    endIndent: 190,
                    thickness: 4,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Color(0xff9e9e9e),
                        size: 18,
                      ),
                      Text(
                        '150 People like this',
                        style: TextStyle(
                          color: Color(0xff9e9e9e),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.comment,
                        color: const Color(0xff9e9e9e9e),
                        size: 20,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text('67')
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      widget.documentSnapshot!['placedetail'],
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        wordSpacing: 3,
                        color: Color(0xff596d76),
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'To Do',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  const Divider(
                    endIndent: 290,
                    color: Colors.blue,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return TravelGuide(
                                    documentSnapshot: widget.documentSnapshot,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 100,
                            width: 160,
                            decoration: BoxDecoration(
                                color: const Color(
                                  0xff438afe,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.swipe_left,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Travel Guide',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const NearByHotels();
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 100,
                            width: 160,
                            decoration: BoxDecoration(
                                color: const Color(0xffffab40),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.hotel,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Nearby Hotels',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const NearByRestaurant();
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 100,
                            width: 160,
                            decoration: BoxDecoration(
                                color: const Color(
                                  0xffff4181,
                                ),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.restaurant_menu_outlined,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Nearby Restaurant',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const UserReveiws();
                              },
                            ));
                          },
                          child: Container(
                            height: 100,
                            width: 160,
                            decoration: BoxDecoration(
                                color: const Color(0xff536dfe),
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, top: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.reviews,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'User Reviews',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Your might also like',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    color: Colors.blue,
                    endIndent: 230,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return Center();
                                },
                              ),
                            );
                          },
                          child: Container(
                            width: 140,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(listPageViewData[3].image),
                                  fit: BoxFit.cover),
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              fontSize: 12,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 10,
                                  child: Text(
                                    listPageViewData[2].placeName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
