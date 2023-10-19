import 'package:flutter/material.dart';
import 'package:travelhour/view/Home/components/ImageSlider/imageSlide.dart';
import 'package:travelhour/view/Home/components/places/placesinkpk/placesinkpk.dart';
import 'package:travelhour/view/Home/components/places/recentyladdedplaces/recentyladdplace.dart';
import 'package:travelhour/view/Home/components/places/recommendedplaces/recomendedplaces.dart';
import 'package:travelhour/view/Home/components/search.dart';

import 'components/header.dart';
import 'components/places/placesingilgit/placesingilgit.dart';
import 'components/places/popularplaces/popularplaces.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});
  Future<void> _refresh() {
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 18, left: 20, right: 20, bottom: 10),
              child: Column(
                children: [
                  HeaderSection(),
                  SizedBox(
                    height: 25,
                  ),
                  SearchSection(),
                  SizedBox(
                    height: 25,
                  ),
                  ImagePageView(),
                  SizedBox(
                    height: 10,
                  ),
                  PopularPlaces(),
                  SizedBox(
                    height: 10,
                  ),
                 RecentlyPlaces(),
                  SizedBox(
                    height: 25,
                  ),
                  PlacesInGilgit(),
                  SizedBox(
                    height: 25,
                  ),
                  PlacesInKpk(),
                  SizedBox(
                    height: 18,
                  ),
                  RecommendedPlaces()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
