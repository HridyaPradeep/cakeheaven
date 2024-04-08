import 'package:cakeheaven/editaddress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  Future<QuerySnapshot<Map<String, dynamic>>> getAddress() async {
    var user = FirebaseAuth.instance.currentUser!.uid;
    print(user);
    var data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user)
        .collection("otherdetails")
        .get();
    print(data.docs.last.id);
    return data;
  }

  Upload(
      {required String id ,
        required String pincode,
      required String state,
      required String landmark,
      required String house,
      required String Name,
      required String phonenumber}) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('otherdetails').doc(id)
        .update({
      "pin": pincode,
      "state": state,
      "land": landmark,
      "house": house,
      "name": Name,
      "number": phonenumber
    });
  }

  TextEditingController pincontroler = TextEditingController();
  TextEditingController statecontroler = TextEditingController();
  TextEditingController housecontroler = TextEditingController();
  TextEditingController landcontroler = TextEditingController();
  TextEditingController namecontroler = TextEditingController();
  TextEditingController phonecontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Address"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getAddress(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
             pincontroler.text = snapshot.data!.docs.last["pin"];
             statecontroler.text=snapshot.data!.docs.last["state"];
             housecontroler.text=snapshot.data!.docs.last["house"];
             landcontroler.text=snapshot.data!.docs.last["land"];
             namecontroler.text=snapshot.data!.docs.last["name"];
phonecontroler.text=snapshot.data!.docs.last["number"];


              return SingleChildScrollView(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Address info",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 15,
                          width: 44,
                          decoration: BoxDecoration(

                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Editing(docid:),));
                                getAddress();
                              },

                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: pincontroler,
                            decoration: InputDecoration(
                                hintText: "pincode",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(150),
                                )),
                                fillColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: statecontroler,
                            decoration: InputDecoration(
                                hintText: "state",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(150),
                                )),
                                fillColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: housecontroler,
                            decoration: InputDecoration(
                                hintText: "House/flat/office no",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(150),
                                )),
                                fillColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: landcontroler,
                            decoration: InputDecoration(
                                hintText: "Land mark",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(150),
                                )),
                                fillColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            children: [
                              Text(
                                "Personal info",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: namecontroler,
                            decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(150),
                                )),
                                fillColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: phonecontroler,
                            decoration: InputDecoration(
                                hintText: "Phone number",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(150),
                                )),
                                fillColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                filled: true),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: InkWell(
                            onTap: () {
                              Upload(
                                pincode: pincontroler.text,
                                state: statecontroler.text,
                                landmark: landcontroler.text,
                                house: housecontroler.text,
                                Name: namecontroler.text,
                                phonenumber: phonecontroler.text, id: snapshot.data!.docs.last.id,
                              );

                              Fluttertoast.showToast(msg: "Address saved");
                            },
                            child: Ink(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.pinkAccent),
                              child: Text(
                                'save Address',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Text("Something went wrong");
            }
          },
        ));
  }
}
