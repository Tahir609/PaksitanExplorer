import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              cardItem('Total user', 200),
              const SizedBox(
                width: 30,
              ),
              cardItem('Total Places', 40),
              const SizedBox(
                width: 30,
              ),
              cardItem('Total Blogs', 13),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              cardItem('Total Notifications', 5),
              const SizedBox(
                width: 30,
              ),
              cardItem('Feature Items', 19),
              const SizedBox(
                width: 30,
              ),
              cardItem('Total States', 7),
            ],
          ),
        ],
      ),
    );
  }

  cardItem(String name, int number) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 22),
        height: 190,
        width: 300,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name.toUpperCase(),
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff858585),
              ),
            ),
            Divider(
              color: Color(0xff7c4dff),
              indent: 2,
              endIndent: 210,
              thickness: 2,
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: Color(0xff7c4dff),
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  number.toString(),
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
