import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  searchFromFirebase(String query) {
    final CollectionReference places =
        FirebaseFirestore.instanceFor(app: Firebase.app('learn'))
            .collection('punjab');
    final place = places.where('placename',isEqualTo: query).get();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  searchFromFirebase(value);
                },
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xffffffff),
                  border: InputBorder.none,
                  hintText: "Search & Explore Places",
                  hintStyle: const TextStyle(
                    color: Color(0xff494949),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      icon: const BackButton(
                        color: Color(0xff494949),
                      ),
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          controller.clear();
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.cancel_sharp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(17.0),
                child: Text(
                  'Recent Search(s)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(),
              Center(
                child: Column(
                  children: const [
                    Icon(
                      Icons.search,
                      size: 120,
                      color: Color(0xff9e9e9e),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Search for Places',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff616161),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'You haven\'t searched for any items yet.',
                      style: TextStyle(color: Color(0xff616161)),
                    ),
                    Text(
                      'Try now-we will help you.',
                      style: TextStyle(color: Color(0xff616161)),
                    ),
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
