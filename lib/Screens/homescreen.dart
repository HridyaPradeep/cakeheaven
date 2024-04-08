import 'package:cakeheaven/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cakediscription.dart';

import '../update.dart';
import 'bookings.dart';
import 'cart.dart';
import 'login.dart';
import 'myAddress.dart';

class Homis extends StatefulWidget {
  const Homis({super.key});

  @override
  State<Homis> createState() => _HomisState();
}

class _HomisState extends State<Homis> {
  List Slide = [
    'https://darlingquote.com/wp-content/uploads/2021/03/2.png',
    'https://cf.ltkcdn.net/party/images/std-xs/305069-340x226-quotes-birthday-cake-candle.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);

    return Scaffold(
      drawer: Drawer(child: Builder(builder: (context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 182,
                width: 300,
                color: Colors.pink.shade50,
                child: DrawerHeader(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("asset/user.jpg"),
                      radius: 28,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("details")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  snapshot.data!.docs[0]["name"],
                                  style: TextStyle(
                                      color: Colors.pinkAccent, fontSize: 14),
                                ),

                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60),
                                      child: Text(
                                        snapshot.data!.docs[0]['email'],
                                        style: TextStyle(
                                            color: Colors.pinkAccent,
                                            fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    InkWell(
                                      child: Icon(
                                        Icons.edit,
                                        size: 19,
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return Updates(
                                              docid: snapshot.data!.docs[0].id,
                                            );
                                          },
                                        ));
                                      },
                                    )
                                  ],
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 170,bottom:10),
                                //   child: Icon(Icons.edit,size: 13,),
                                // )
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                  ],
                )),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Bookingss(),
                          ));
                        },
                        child: Text(
                          'my booking',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.pinkAccent,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 400),
                child: Expanded(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Address(),
                            ));
                          },
                          child: Text(
                            'my address',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.pinkAccent,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Logi(),
                  ));
                },
                child: Container(
                  height: 50,
                  width: 800,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'LOG OUT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 07,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ]);
      })),
      appBar: AppBar(
        actions: [
          StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var myData = snapshot.data!.docs;
                print(myData.length);
                return Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return Cartt();
                          },
                        ));
                      },
                      child: Badge(
                          label: Text(myData.length.toString()),
                          smallSize: 17,
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 30,
                          )),
                    ));
              } else {
                return SizedBox();
              }
            },
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("carts")
                .snapshots(),
          ),
        ],
        backgroundColor: Colors.pink.shade100,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 130,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('categories')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                snapshot.data!.docs[index]['name'];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Categori(
                                              catid: snapshot.data!.docs[index]
                                                  ['name'],
                                              title: snapshot.data!.docs[index]
                                                  ['name'],
                                            )));
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 95),
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['title'],
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: (BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]['photo'])),
                                    shape: BoxShape.circle)),
                              ),
                            ),
                          );
                        });
                  } else {
                    return SizedBox();
                  }
                }),
          ),
          SizedBox(
            height: 10,
          ),
          CarouselSlider(
            options: CarouselOptions(height: 150, autoPlay: true),
            items: [
              'https://darlingquote.com/wp-content/uploads/2021/03/2.png',
              'https://cf.ltkcdn.net/party/images/std-xs/305069-340x226-quotes-birthday-cake-candle.jpg'
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          image: DecorationImage(image: NetworkImage('$i'))),
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage('$i'),
                        height: 100,
                      ));
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  'Trending Cakes',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent.shade200),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 270,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('items').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Discription(
                                  docid: snapshot.data!.docs[index].id,
                                  cl: 'items');
                            }));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            height: 100,
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
                                    snapshot.data!.docs[index]['image']),
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
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                }),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                'Wedding Cakes',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent.shade200),
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * .75,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('weddingcake')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1 / 1.4 / 1),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return Discription(
                                  docid: snapshot.data!.docs[index].id,
                                  cl: 'weddingcake',
                                );
                              }));
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(5),
                              height: 130,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 8)
                                  ]),
                              child: Column(
                                children: [
                                  Image.network(
                                    snapshot.data!.docs[index]['image'],
                                  ),
                                  Text(snapshot.data!.docs[index]['name']),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.currency_rupee,
                                        weight: 20,
                                        size: 17,
                                      ),
                                      Text(snapshot.data!.docs[index]['price']
                                          .toString())
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                'Kids Cakes',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent.shade200),
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * .75,
              child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('kids').snapshots(),
                  builder: (context, snapshot) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1 / 1.4 / 1),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Discription(
                                docid: snapshot.data!.docs[index].id,
                                cl: 'kids',
                              );
                            }));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            height: 130,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 8)
                                ]),
                            child: Column(
                              children: [
                                Image.network(
                                  snapshot.data!.docs[index]['image'],
                                ),
                                Text(snapshot.data!.docs[index]['name']),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.currency_rupee,
                                      weight: 20,
                                      size: 17,
                                    ),
                                    Text(snapshot.data!.docs[index]['price']
                                        .toString())
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 14),
          //     child: Text(
          //       'Premium Cakes',
          //       style: TextStyle(
          //           fontSize: 20,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.pinkAccent.shade200),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 7,
          // ),
          // Expanded(
          //   child: SizedBox(
          //     height: MediaQuery.sizeOf(context).height * .75,
          //     child: StreamBuilder(
          //         stream: FirebaseFirestore.instance
          //             .collection('premium')
          //             .snapshots(),
          //         builder: (context, snapshot) {
          //           return GridView.builder(
          //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: 2, childAspectRatio: 1 / 1.4 / 1),
          //             itemCount: snapshot.data!.docs.length,
          //             itemBuilder: (context, index) {
          //               return InkWell(
          //                 onTap: () {
          //                   Navigator.of(context)
          //                       .push(MaterialPageRoute(builder: (context) {
          //                     return Discription(
          //                       docid: snapshot.data!.docs[index].id,
          //                       cl: 'premium',
          //                     );
          //                   }));
          //                 },
          //                 child: Container(
          //                   margin: EdgeInsets.all(10),
          //                   padding: EdgeInsets.all(5),
          //                   height: 130,
          //                   width: 150,
          //                   decoration: BoxDecoration(
          //                       color: Colors.white,
          //                       boxShadow: [
          //                         BoxShadow(
          //                             color: Colors.grey.withOpacity(0.5),
          //                             spreadRadius: 2,
          //                             blurRadius: 8)
          //                       ]),
          //                   child: Column(
          //                     children: [
          //                       Image.network(
          //                         snapshot.data!.docs[index]['image'],
          //                       ),
          //                       Text(snapshot.data!.docs[index]['name']),
          //                       Row(
          //                         mainAxisAlignment: MainAxisAlignment.center,
          //                         children: [
          //                           Icon(
          //                             Icons.currency_rupee,
          //                             weight: 20,
          //                             size: 17,
          //                           ),
          //                           Text(snapshot.data!.docs[index]['price']
          //                               .toString())
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               );
          //             },
          //           );
          //         }),
          //   ),
          // ),
        ],
      ),
    );
  }

  // listtile({required Icon icon, required String title}) {}
}
