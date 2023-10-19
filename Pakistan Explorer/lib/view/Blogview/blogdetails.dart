import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:travelhour/data/savedblogs_data.dart';
import 'package:travelhour/model/savedblogs_model.dart';

import '../../data/blogdata.dart';
import '../../model/blog_model.dart';

class BlogDetails extends StatefulWidget {
  final DocumentSnapshot? documentSnapshot;
  BlogDetails({super.key, required this.documentSnapshot});

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  bool isSelected = false;
  bool isSelected2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffeeeeee),
        leading: BackButton(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 20,
                        color: Colors.grey,
                      ),
                      Text('26 March 2020')
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    widget.documentSnapshot!['titile'],
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    endIndent: 190,
                    thickness: 4,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Image.network(widget.documentSnapshot!['imgurl']),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                widget.documentSnapshot!['description'],
                style: const TextStyle(
                  color: Color(0xff596d76),
                  fontSize: 16,
                  height: 1.7,
                  letterSpacing: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Color(0xff9e9e9e),
                      ),
                      Text('123 People like this')
                    ],
                  ),
                  Row(
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
                                size: 26,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                size: 26,
                              ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isSelected2 = !isSelected2;
                             if (isSelected2) {
                              savedBlogs.add(SavedBlogs(
                                  snapshot: widget.documentSnapshot!));
                            }
                          });
                        },
                        icon: isSelected2
                            ? const Icon(
                                Icons.bookmark,
                                size: 26,
                              )
                            : const Icon(
                                Icons.bookmark_border,
                                size: 26,
                              ),
                      ),
                    ],
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
