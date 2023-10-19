import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class blog extends StatefulWidget {
  const blog({super.key});

  @override
  State<blog> createState() => _blogState();
}

class _blogState extends State<blog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final CollectionReference blogs =
      FirebaseFirestore.instance.collection('blogs');
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1300,
      margin: const EdgeInsets.only(top: 18, left: 18, right: 18),
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Blogs ',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const Divider(
              color: Color(0xff7c4dff),
              indent: 3,
              endIndent: 1040,
              thickness: 3,
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: blogs.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: 1300,
                    height: 590,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: 1300,
                          padding: const EdgeInsets.all(15.0),
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Color(0xffe6e6e6),
                            ),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  documentSnapshot['imgurl'],
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else
                                      return CircularProgressIndicator();
                                  },
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      documentSnapshot['titile'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          size: 16,
                                        ),
                                        Text('24 March 20'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffeeeeee),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.star_border_outlined,
                                                size: 20,
                                              ),
                                              Text('13'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffeeeeee),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.comment,
                                                size: 20,
                                              ),
                                              Text('13'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print('Clicked Deleted....');
                                            _update(documentSnapshot);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffeeeeee),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Icon(
                                              Icons.edit,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _showDeleteConfirmationDialog(
                                                documentSnapshot);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 40,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffeeeeee),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Icon(
                                              Icons.delete,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      titleController.text = documentSnapshot['titile'];
      imageUrlController.text = documentSnapshot['imgurl'];
      descriptionController.text = documentSnapshot['description'];
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 100,
            left: 100,
            right: 100,
            bottom: MediaQuery.of(context).viewInsets.bottom + 200,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Blogs Details',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 30,
                ),
                formField(
                  titleController,
                  TextInputType.text,
                  'Title',
                  'Enter Title',
                ),
                const SizedBox(
                  height: 20,
                ),
                formField(
                  imageUrlController,
                  TextInputType.text,
                  'Image',
                  'Enter Image Url',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: 6,
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Description'),
                    hintText: "Enter Blog Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 900,
                  height: 50,
                  color: const Color(0xff7c4dff),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(
                          0xff7c4dff,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final String title = titleController.text;
                      final String imgurl = imageUrlController.text;
                      final description = descriptionController.text;
                      if (title != null &&
                          imgurl != null &&
                          description != null) {
                        await blogs.doc(documentSnapshot!.id).update({
                          'titile': title,
                          'imgurl': imgurl,
                          'description': description
                        });
                        titleController.text = '';
                        descriptionController.text = '';
                        imageUrlController.text = '';
                      }
                    },
                    child: const Text(
                      'Update Blog',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      [DocumentSnapshot? documentSnapshot]) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this Blog?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                blogs.doc(documentSnapshot!.id).delete();
                Navigator.of(context).pop();
                // You can add your delete logic here
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // Cancel the delete action
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  formField(TextEditingController controller, TextInputType textInputType,
      String labelname, String hint) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
          label: Text(labelname), hintText: hint, border: OutlineInputBorder()),
    );
  }
}
