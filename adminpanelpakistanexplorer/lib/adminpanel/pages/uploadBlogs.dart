import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class uploadBlogs extends StatefulWidget {
  const uploadBlogs({super.key});

  @override
  State<uploadBlogs> createState() => _uploadBlogsState();
}

class _uploadBlogsState extends State<uploadBlogs> {
  final CollectionReference blogs =
      FirebaseFirestore.instance.collection('blogs');
  TextEditingController titleController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000,
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
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
                  if (title != null && imgurl != null && description != null) {
                    await blogs.add({
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
                  'Upload Blog',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
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
