import 'package:flutter/material.dart';
import 'package:travelhour/view/Blogview/blog.dart';
import 'package:travelhour/view/Home/home.dart';
import 'package:travelhour/view/Profile/profile.dart';
import 'package:travelhour/view/Saved/saved.dart';
import 'package:travelhour/view/States/state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationClass extends StatefulWidget {
  BottomNavigationClass({super.key});

  @override
  State<BottomNavigationClass> createState() => _BottomNavigationClassState();
}

class _BottomNavigationClassState extends State<BottomNavigationClass> {
  List<Widget> listOfWidget = [
    const MyHome(),
    const StateClass(),
    const BlogClass(),
    const SavedClass(),
    const ProfileClass()
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: const Color(0xff9e9e9e),
        selectedItemColor: const Color(0xff448afa),
        currentIndex: selectedIndex,
        elevation: 10,
        iconSize: 26,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.window_outlined,
            ),
            label: "State",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: "Blog",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_border_outlined,
            ),
            label: "Saved",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: listOfWidget[selectedIndex],
    );
  }
}
