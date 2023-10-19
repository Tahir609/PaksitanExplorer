import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travelhour/view/Profile/profile.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  final ref = FirebaseDatabase.instance.ref('Users');
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Pakistan Explorer',
              style: TextStyle(
                  fontSize: 26,
                  color: Color(0xff424242),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Explore Pakistan',
              style: TextStyle(
                color: Color(0xff757575),
                fontSize: 15,
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ProfileClass();
                },
              ),
            );
          },
          child: StreamBuilder(
            stream: ref.child(user!.uid.toString()).onValue,
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const CircleAvatar(
                  maxRadius: 27,
                  child: Icon(
                    Icons.person,
                    size: 25,
                  ),
                );
              } else if (snapshot.hasData) {
                Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                return map['profile'].toString() == ""
                    ? const CircleAvatar(
                        maxRadius: 27,
                        child: Icon(
                          Icons.person,
                          size: 25,
                        ),
                      )
                    : Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              map['profile'].toString(),
                            ),
                          ),
                        ),
                      );
              } else {
                return const Text('');
              }
            },
          ),
        ),
        // const CircleAvatar(
        //   maxRadius: 25,
        //   backgroundColor: Color(0xff757575),
        //   child: Icon(
        //     Icons.person,
        //     size: 30,
        //     color: Colors.white,
        //   ),
        // )
      ],
    );
  }
}
