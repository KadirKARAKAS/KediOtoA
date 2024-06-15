import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomePage/Page/home_page.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await handleAppStart();
}

Future<void> handleAppStart() async {
  FirebaseAuth auth = FirebaseAuth.instance;

  if (auth.currentUser == null) {
    //kullanıcı oturum açmamışsa
    await FirebaseAuth.instance.signInAnonymously();
    Map<String, dynamic> mapSaveData = {};
    Map<Bool, dynamic> adminBoolInfo = {};
    userID = auth.currentUser!.uid;

    if (Platform.isIOS) {
      mapSaveData = {'Platform': 'iOS'};
      adminBoolInfo = {};
    } else {
      adminBoolInfo = {'Admin': admin};
    }

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userID)
        .set(mapSaveData);

    runApp(const MaterialApp(
      home: HomePage(),
    ));
  } else {
    //kullanıcı oturum açmışsa

    final userRef = FirebaseFirestore.instance
        .collection("Users")
        .doc(userID)
        .collection("Products");

    final querySnapshot = await userRef.get();
    getdataList.clear();

    querySnapshot.docs.forEach((doc) {
      docIDList.add(doc.id);
      getdataList.add(doc.data());
    });

    if (getdataList.isEmpty) {
      print("LİSTE BOŞŞşŞ");
      runApp(const MaterialApp(
        home: HomePage(),
      ));
    } else {
      print("LİSTE DOLUUUĞ");
      runApp(const MaterialApp(
        home: HomePage(),
      ));
    }
  }
}
