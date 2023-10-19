import 'package:flutter/material.dart';

import '../auth/login.dart';

var appBar = AppBar(
  backgroundColor: Color(0xffffffff),
  actions: [
    InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        alignment: Alignment.center,
        width: 130,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
    SizedBox(
      width: 70,
    ),
  ],
  leadingWidth: 500,
  leading: Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        RichText(
          text: TextSpan(
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
);
