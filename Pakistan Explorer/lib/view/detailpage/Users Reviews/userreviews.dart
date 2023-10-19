import 'package:flutter/material.dart';

class UserReveiws extends StatefulWidget {
  const UserReveiws({super.key});

  @override
  State<UserReveiws> createState() => _UserReveiwsState();
}

class _UserReveiwsState extends State<UserReveiws> {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff5f5f5),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text('User Reveiws'),
          leading: BackButton(
            color: Colors.white,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 10, bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(Icons.person),
                            maxRadius: 23,
                          ),
                          title: Text(
                            'Tahir Naeem',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('This is one two'),
                          trailing: Text('10 Aug 2023'),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                        width: 1, color: Color.fromARGB(255, 233, 233, 233)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffeeeeee),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write a Review",
                          prefix: SizedBox(
                            width: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              size: 27,
                              color: Color(0xff616161),
                            ),
                            onPressed: () {},
                          )),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
