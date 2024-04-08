import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cakediscription.dart';

class Categori extends StatefulWidget {
  const Categori({super.key, required this.catid, required this.title});
  final String catid;
  final String title;

  @override
  State<Categori> createState() => _CategoriState();
}

class _CategoriState extends State<Categori> {
  @override
  Widget build(BuildContext context) {
    print(widget.catid);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body:StreamBuilder(
        stream:FirebaseFirestore.instance.collection('items').where('catid',isEqualTo: widget.catid).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return GridView.builder(
              itemCount:snapshot.data!.docs.length
              , itemBuilder: (context, index) {

              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return
                    Discription(docid: snapshot.data!.docs[index].id, cl: 'items',);
                  },));
                },
                child: Container(

                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    height: 70,
                    width: 190,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 8)
                        ]),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(

                          snapshot.data!.docs[index]['image'],
                          height: 150,
                        ),
                        Row(
                          children: [
                            Text(snapshot.data!.docs[index]['name']),

                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.currency_rupee,
                              size: 17,
                            ),
                            Text(snapshot.data!.docs[index]["price"]
                                .toString())
                          ],
                        )
                      ],
                    )
                ),
              );},
              gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1/1.4
              ),

            );

          }
          else{
            return
            SizedBox();
          }


        }
      ),


    );

  }

}
