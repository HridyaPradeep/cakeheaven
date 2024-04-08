import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bookingss extends StatefulWidget {
  const Bookingss({super.key});

  @override
  State<Bookingss> createState() => _BookingssState();
}

class _BookingssState extends State<Bookingss> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text(
          'My bookings',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("booking")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                      height: 140,
                      child: Card(
                          color: Colors.white60,
                          child: Row(children: [
                            Image.network(snapshot.data!.docs[index]['image']),
                            SizedBox(
                              width: 17,
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 50),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        size: 15,
                                      ),
                                      Text(snapshot.data!.docs[index]['price']
                                          .toString()),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ])));
                });
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
