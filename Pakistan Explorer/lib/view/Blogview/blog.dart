import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travelhour/view/Blogview/blogdetails.dart';

import '../../data/blogdata.dart';
import '../../model/blog_model.dart';

class BlogClass extends StatefulWidget {
  const BlogClass({super.key});

  @override
  State<BlogClass> createState() => _BlogClassState();
}

class _BlogClassState extends State<BlogClass> {
  final CollectionReference blogs =
      FirebaseFirestore.instanceFor(app: Firebase.app('learn'))
          .collection('blogs');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          title: const Text(
            'Blog',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          elevation: 0,
          actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.filter_list,
                color: Colors.black,
              ),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  child: Text('Most Recent'),
                ),
                PopupMenuItem(
                  child: Text('Most Popular'),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.refresh,
                size: 30,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: StreamBuilder(
                stream: blogs.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BlogDetails(
                                      documentSnapshot: documentSnapshot,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(
                                      documentSnapshot['imgurl'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          documentSnapshot['titile'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 8.0),
                                        Text(
                                          documentSnapshot['description'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.favorite,
                                              size: 20,
                                              color: Colors.grey,
                                            ),
                                            Text('121'),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
