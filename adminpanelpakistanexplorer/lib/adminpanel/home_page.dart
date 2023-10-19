import 'package:adminpanelpakistanexplorer/adminpanel/pages/admin.dart';
import 'package:adminpanelpakistanexplorer/adminpanel/pages/blog.dart';
import 'package:adminpanelpakistanexplorer/adminpanel/pages/dashboard.dart';
import 'package:adminpanelpakistanexplorer/adminpanel/pages/places.dart';
import 'package:adminpanelpakistanexplorer/adminpanel/pages/settings.dart';

import 'package:adminpanelpakistanexplorer/adminpanel/pages/uploadBlogs.dart';
import 'package:adminpanelpakistanexplorer/adminpanel/pages/uploadPlaces.dart';
import 'package:adminpanelpakistanexplorer/auth/login.dart';
import 'package:flutter/material.dart';

import '../auth/login.dart';
import '../auth/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          actions: [
            InkWell(
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                alignment: Alignment.center,
                width: 130,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xff7c4dff),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 16,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 70,
            ),
          ],
          leadingWidth: 500,
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Pakistan Explorer',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 25,
                          color: Color(0xff7c4dff),
                        ),
                      ),
                      TextSpan(
                        text: ' - Admin Panel',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff676767),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xffeeeeee),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NavigationRail(
              onDestinationSelected: (value) {
                setState(() {
                  index = value;
                });
              },
              elevation: 1,
              extended: true,
              selectedIndex: index,
              labelType: NavigationRailLabelType.none,
              selectedLabelTextStyle: const TextStyle(color: Color(0xff7c4dff)),
              selectedIconTheme: const IconThemeData(color: Color(0xff7c4dff)),
              destinations: [
                _navigationRailDestination(Icons.dashboard_sharp, "Dashboard"),
                _navigationRailDestination(
                    Icons.location_on_outlined, "Places"),
                _navigationRailDestination(
                    Icons.arrow_circle_up, "Upload Places"),
                _navigationRailDestination(
                    Icons.rocket_launch_outlined, "Blog"),
                _navigationRailDestination(
                    Icons.arrow_circle_up, "Upload Bloc"),
                _navigationRailDestination(
                    Icons.admin_panel_settings_outlined, "Admin"),
                _navigationRailDestination(
                    Icons.settings_applications_outlined, "Settings"),
              ],
            ),
            showPage(),
          ],
        ),
      ),
    );
  }

  showPage() {
    switch (index) {
      case 0:
        return const dashboard();
      case 1:
        return const places();
      case 2:
        return const uploadPlaces();
      case 3:
        return const blog();
      case 4:
        return const uploadBlogs();
      case 5:
        return const admin();
      case 6:
        return const settings();
      default:
        return null;
    }
  }

  _navigationRailDestination(IconData iconData, String label) {
    return NavigationRailDestination(
      padding: const EdgeInsets.symmetric(vertical: 3),
      icon: Icon(iconData),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                )); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
