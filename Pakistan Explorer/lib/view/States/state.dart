import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:travelhour/view/States/kashmir/kashmir.dart';
import 'package:travelhour/view/States/punjab/detailsaboutstate.dart';
import 'package:travelhour/view/States/sindh/sindh.dart';

import '../../data/provincedata.dart';
import '../../model/province_model.dart';
import 'balochistan/balochistan.dart';
import 'gilgit/gilgitstate.dart';
import 'kpk/kpkstate.dart';

class StateClass extends StatefulWidget {
  const StateClass({super.key});

  @override
  State<StateClass> createState() => _StateClassState();
}

class _StateClassState extends State<StateClass> {
  Future<void> _refresh() {
    return Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        leadingWidth: 100,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.refresh,
              color: Color(0xff222222),
              size: 28,
            ),
          )
        ],
        leading: const Padding(
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'States',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff222222)),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Punjabstate();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/punjab.jpg'),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Punjab',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Kashmirstate();
                      },
                    ));
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/kashmir.jpg'),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Kashmir',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Kpkstate();
                      },
                    ));
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/kpk.jpg'),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Khyber Pakhtunkhawan"',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Gilgitstate();
                      },
                    ));
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/gilgit.jpg'),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Gilgit Baltistan',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Balochistanstate();
                      },
                    ));
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/Balochistan-2.jpg'),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Balochistan',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Sidthstate();
                      },
                    ));
                  },
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 5, top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/sindth.jpg'),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Sindh',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
