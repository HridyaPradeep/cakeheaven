import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Editing extends StatefulWidget {
  const Editing({super.key, required this.docid});
  final String docid;

  @override
  State<Editing> createState() => _EditingState();
}

class _EditingState extends State<Editing> {
  update(String pincode, String state, String landmark, String house,
      String Name, String phonenumber)async {
    
    return await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).collection("otherdetails").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
