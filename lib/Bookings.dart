import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bookingg extends StatefulWidget {
  const Bookingg({super.key});

  @override
  State<Bookingg> createState() => _BookinggState();
}

class _BookinggState extends State<Bookingg> {

  addtocat(
      {required String name, required int price, required String image}) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('booking')
        .add({'name': name, "price": price, "image": image});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
