import 'dart:async';

import 'package:cakeheaven/Screens/login.dart';
import 'package:cakeheaven/Screens/registeration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Adminapp.dart';
import 'homescreen.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
   
    // TODO: implement initState

    if (FirebaseAuth.instance.currentUser != null) {
      Timer(Duration(seconds: 5), () {
        if (FirebaseAuth.instance.currentUser!.uid ==
            "TPZRSIqZOhSp0UrJBcQfJBYvUus1")
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return Admis();
          }));
        else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Homis(),
          ));
        }
      });
    } else {
      Timer(Duration(seconds: 5), () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return Logi();
        }));
      });
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset(
                'asset/photo.json',
                height: 100,
                fit: BoxFit.cover,
                width: 230,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                'we deliver our best at affordable cost...',
                style: TextStyle(
                    color: Colors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Regis();
                }));
              },
              child: Text(
                'Get started',
                style: TextStyle(
                  // color: Colors.white,
                 fontSize: 1
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
