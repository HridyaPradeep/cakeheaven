import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminBooking extends StatefulWidget {
  const AdminBooking({super.key});

  @override
  State<AdminBooking> createState() => _AdminBookingState();
}

class _AdminBookingState extends State<AdminBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collectionGroup("booking").snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData){
            var book=snapshot.data!.docs;
            return ListView.builder(
              itemCount: book.length,
              itemBuilder: (context, index) {
              var books=book[index];
              return ListTile(
                title: Row(
                  children: [
                    SizedBox(height: 80,
                    width: 80,child: Image(image: NetworkImage(
                        books["image"]
                      )),),SizedBox(
                      child: Row(
                        children: [
                          Text(books["name"],),Text(books["price"].toString())
                        ],
                      ),
                    )
                  ],
                ),
              );
            },);
          }else{
            return SizedBox();
          }
        },

      ),

    );
  }
}
