import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelhour/view/SplashScreen/onboardingscree.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../utils/utilities.dart';
import 'contacts.dart';

class ProfileClass extends StatefulWidget {
  const ProfileClass({super.key});

  @override
  State<ProfileClass> createState() => _ProfileClassState();
}

class _ProfileClassState extends State<ProfileClass> {
  DateTime datetime = DateTime.now();
  TextEditingController firstName = TextEditingController();

  bool isSelected = false;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final ref = FirebaseDatabase.instance.ref('Users');
  final auth = FirebaseAuth.instance;

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    void uploadImage() async {
      firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref(
        '/profileImage' + user!.uid.toString(),
      );
      firebase_storage.UploadTask uploadTask = storageRef.putFile(
        File(image!.path).absolute,
      );
      await Future.value(uploadTask);
      final newUrl = await storageRef.getDownloadURL();

      ref
          .child(
        user.uid.toString(),
      )
          .update(
        {
          'profile': newUrl.toString(),
        },
      ).then((value) {
        _image = null;
      });
    }

    Future pickGalleryImage() async {
      final pickFile = await picker.pickImage(
          source: ImageSource.gallery, imageQuality: 100);
      if (pickFile != null) {
        setState(() {
          _image = XFile(pickFile.path);
          uploadImage();
        });
      }
    }

    Future pickCameraImage() async {
      final pickFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
      if (pickFile != null) {
        setState(() {
          _image = XFile(pickFile.path);
          uploadImage();
        });
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        leadingWidth: 70,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Center(
            child: Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: ref.child(user!.uid.toString()).onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    // color: Colors.red,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 10),
                                child: image == null
                                    ? map['profile'].toString() == ""
                                        ? const CircleAvatar(
                                            maxRadius: 50,
                                            child: Icon(
                                              Icons.person,
                                              size: 40,
                                            ),
                                          )
                                        : Container(
                                            height: 110,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  map['profile'].toString(),
                                                ),
                                              ),
                                            ),
                                          )
                                    : Container(
                                        height: 110,
                                        width: 110,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                                File(image!.path).absolute),
                                          ),
                                        ),
                                      ),
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 120,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                onTap: () {
                                                  pickCameraImage();
                                                  Navigator.of(context).pop();
                                                },
                                                leading: const Icon(
                                                    Icons.camera_alt_outlined),
                                                title: const Text('Camera'),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  pickGalleryImage();
                                                  Navigator.of(context).pop();
                                                },
                                                leading:
                                                    const Icon(Icons.image),
                                                title: const Text('Gallery'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 10,
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              map['firstname'].toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: Text(
                            map['email'].toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.date_range),
                          title: Text(
                              '${datetime.day}-${datetime.month}-${datetime.year}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Update User Name'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: firstName,
                                          decoration: const InputDecoration(
                                            hintText: "Enter your Name",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        ref.child(user.uid).update({
                                          'firstname':
                                              firstName.text.toString(),
                                        }).then((value) {
                                          Utils().toastMessage(
                                              "User name updatee successfully!");
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          leading: const Icon(Icons.edit),
                          title: const Text('Edit Profile',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          trailing: Icon(Icons.keyboard_arrow_right_outlined),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Logout'),
                                  content: const Text(
                                      'Do you really want to logout from the app?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        auth.signOut().then((value) {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const OnBoardingScreen();
                                              },
                                            ),
                                          );
                                        }).onError((error, stackTrace) {
                                          Utils().toastMessage(
                                            error.toString(),
                                          );
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No'),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: const ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Logout',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            trailing: Icon(Icons.keyboard_arrow_right_outlined),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, top: 20),
                          child: Text(
                            'General Settings',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        ListTile(
                          leading:
                              const Icon(Icons.notifications_none_outlined),
                          title: const Text('Notifications'),
                          trailing: Switch(
                            onChanged: (value) {
                              setState(() {
                                isSelected = value;
                              });
                            },
                            value: isSelected,
                          ),
                        ),
                        const Divider(),
                        const ListTile(
                          leading: Icon(Icons.language),
                          title: Text('Language'),
                          trailing: Icon(Icons.keyboard_arrow_right_outlined),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const ContactUsClass();
                              },
                            ));
                          },
                          child: const ListTile(
                            leading: Icon(Icons.contacts),
                            title: Text('Contact Us'),
                            trailing: Icon(Icons.keyboard_arrow_right_outlined),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text('Something Went Wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
