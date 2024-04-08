import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../cakediscription.dart';

class Cartt extends StatefulWidget {
  Cartt({super.key});

  @override
  State<Cartt> createState() => _CarttState();
}

class _CarttState extends State<Cartt> {
  removeFromCart(doc) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("carts")
        .doc(doc)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text(
          'Cake Heaven',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        actions: [
          SizedBox(
            width: 50,
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('carts')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Discription(docid: snapshot.data!.docs[index]['docid'], cl: snapshot.data!.docs[index]['cl'])));
                      },
                      child: SizedBox(
                        height: 140,
                        child: Card(
                          color: Colors.white60,
                          child: Row(
                            children: [
                              Image.network(
                                  snapshot.data!.docs[index]['image']),
                              SizedBox(
                                width: 17,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 50),
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
                                        Text(snapshot
                                            .data!.docs[index]['price']
                                            .toString()),
                                        IconButton(
                                            onPressed: () {
                                              removeFromCart(snapshot
                                                  .data!.docs[index].id);
                                              Fluttertoast.showToast(
                                                  msg: 'item delected',
                                                  backgroundColor: Colors.red);
                                            },
                                            icon: const Padding(
                                              padding: EdgeInsets.only(left: 100),
                                              child: Icon(
                                                Icons.delete,
                                                size: 20,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return SizedBox();
            }
          }),
    );
  }
}
