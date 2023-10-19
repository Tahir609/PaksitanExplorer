import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelhour/view/SplashScreen/splashscreen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'learn',
    options: const FirebaseOptions(
        apiKey: "AIzaSyB3lmjZnwPguVbJsQtk30ienmub0Zurc5Q",
        authDomain: "learn-9b975.firebaseapp.com",
        projectId: "learn-9b975",
        storageBucket: "learn-9b975.appspot.com",
        messagingSenderId: "549376795843",
        appId: "1:549376795843:web:3a5ee09fa854540d3bee76",
        measurementId: "G-0HH1RYH9V3"),
  );
  await Firebase.initializeApp(
    name: 'pakistanexplore',
    options: const FirebaseOptions(
        apiKey: "AIzaSyA0GMgkwdAMtf8QGTjlz2DgSn4ApOsFJvw",
        authDomain: "pakistanexplore-cdb45.firebaseapp.com",
        databaseURL:
            "https://pakistanexplore-cdb45-default-rtdb.firebaseio.com",
        projectId: "pakistanexplore-cdb45",
        storageBucket: "pakistanexplore-cdb45.appspot.com",
        messagingSenderId: "618266762866",
        appId: "1:618266762866:web:6eb1f035e4c22a3360eceb",
        measurementId: "G-2SV7SMKX2M"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SplashScreen(),
    );
  }
}

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final CollectionReference users =
//       FirebaseFirestore.instanceFor(app: Firebase.app('learn'))
//           .collection('users');
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: users.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     snapshot.data!.docs[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(documentSnapshot['name']),
//                     subtitle: Text(documentSnapshot['email']),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(
//               child: Text('Hello'),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
