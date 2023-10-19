import 'package:flutter/material.dart';

import '../../data/savedblogs_data.dart';
import '../../data/saveplace_data.dart';

class SavedClass extends StatefulWidget {
  const SavedClass({super.key});

  @override
  State<SavedClass> createState() => _SavedClassState();
}

class _SavedClassState extends State<SavedClass> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xffff5f5f5),
        appBar: AppBar(
          backgroundColor: const Color(0xfffffffff),
          elevation: 0,
          title: const Text(
            'Bookmark',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          bottom: const TabBar(
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                text: "Saved Places",
              ),
              Tab(
                text: "Saved Blog",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            place(),
            blogs(),
          ],
        ),
      ),
    );
  }

  place() {
    if (savedplaces.isNotEmpty) {
      return ListView.builder(
        itemCount: savedplaces.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            // color: Colors.red,
            height: 190,
            width: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 16),
                    child: Container(
                      width: double.infinity,
                      height: 135,
                      color: Color(0xffeeeeee),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, left: 80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              savedplaces[index].snapshot['placename'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 18,
                                  color: Color(0xff8c8c8c),
                                ),
                                Text(
                                  savedplaces[index].snapshot['locationname'],
                                  style: TextStyle(
                                      color: Color(0xff8c8c8c), fontSize: 8),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              color: Colors.blue,
                              endIndent: 80,
                              indent: 43,
                              thickness: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: 18,
                                ),
                                Text('96'),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    savedplaces.removeAt(index);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.delete_outline,
                                    size: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              savedplaces[index].snapshot['img1url'])),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/save-instagram (1).png',
            height: 50,
            width: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'No Place Found',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text('Save your favourite place here with')
        ],
      );
    }
  }

  blogs() {
    if (savedBlogs.isNotEmpty) {
      return ListView.builder(
        itemCount: savedBlogs.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            // color: Colors.red,
            height: 190,
            width: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 16),
                    child: Container(
                      width: double.infinity,
                      height: 135,
                      color: Color(0xffeeeeee),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 120,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              savedBlogs[index].snapshot['titile'],
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              color: Colors.blue,
                              endIndent: 80,
                              indent: 43,
                              thickness: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.favorite_border,
                                  size: 18,
                                ),
                                Text('96'),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    savedBlogs.removeAt(index);
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.delete_outline,
                                    size: 18,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              savedBlogs[index].snapshot['imgurl'])),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/save-instagram (1).png',
            height: 50,
            width: 50,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'No Blogs Found',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text('Save your favourite Blogs here with')
        ],
      );
    }
  }
}
