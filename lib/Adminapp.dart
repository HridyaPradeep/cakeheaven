import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'Screens/login.dart';

class Admis extends StatefulWidget {
  const Admis({Key? key}) : super(key: key);

  @override
  State<Admis> createState() => _AdmisState();
}

class _AdmisState extends State<Admis> {
  TextEditingController catidctrl = TextEditingController();
  TextEditingController namectrl = TextEditingController();
  TextEditingController discriptionctrl = TextEditingController();
  TextEditingController pricectrl = TextEditingController();
  File? selectimage;
  String? selctedValue;

  getimage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectimage = File(pickedImage.path);
      });
    }
  }

  Adding() async {
    final response =
        FirebaseStorage.instance.ref().child('my_image/${selectimage!.path}');
    var task = response.putFile(selectimage!);
    await task.whenComplete(() async {
      var tasklink = await response.getDownloadURL();
      print("=====================${tasklink}");
      await FirebaseFirestore.instance.collection(selctedValue!).add({
        'image': tasklink,
        'price': num.parse(pricectrl.text),
        'discription': discriptionctrl.text,
        'name': namectrl.text
      });

      Fluttertoast.showToast(msg: "image uploaded");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 10),
              Text("Select category"),
              Expanded(child: SizedBox()),
              DropdownButton<String>(
                value: selctedValue,
                items: [
                  DropdownMenuItem(
                    child: Text("ButterScotchCake"),
                    value: "ButterScotchCake",
                  ),
                  DropdownMenuItem(
                    child: Text("Mango"),
                    value: "Mango",
                  ),
                  DropdownMenuItem(
                    child: Text("Blueberry Cakes"),
                    value: "BlueberryCakes",
                  ),
                  DropdownMenuItem(
                    child: Text("Blackforest Cakes"),
                    value: "BlackforestCakes",
                  ),
                  DropdownMenuItem(
                    child: Text("Pineapple Cakes"),
                    value: "PineappleCakes",
                  ),
                  DropdownMenuItem(
                    child: Text("Chocolate Cakes"),
                    value: "ChocolateCakes",
                  ),
                  DropdownMenuItem(
                    child: Text("Kids Collection"),
                    value: "kids",
                  ),
                  DropdownMenuItem(
                    child: Text("Premium Collection"),
                    value: "premium",
                  ),
                  DropdownMenuItem(
                    child: Text("Wedding Cake Collection"),
                    value: "weddingcake",
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    selctedValue = value;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            controller: namectrl,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Description",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            controller: discriptionctrl,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Price",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            controller: pricectrl,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              getimage();
            },
            child: Text("Pick Image"),
          ),
          ElevatedButton(
            onPressed: () {
              if (selctedValue != null &&
                  pricectrl.text.isNotEmpty &&
                  discriptionctrl.text.isNotEmpty &&
                  namectrl.text.isNotEmpty &&
                  selectimage != null) {
                Adding();
              }
            },
            child: Text('Submit'),
          ),
          if (selectimage != null) Image.file(selectimage!),
          SizedBox(height: 20),
          // InkWell(
          //   onTap: () async {
          //     await FirebaseAuth.instance.signOut();
          //     Navigator.of(context).pushReplacement(MaterialPageRoute(
          //       builder: (context) => Logi(),
          //     ));
          //   },
          //   child: Container(
          //     height: 50,
          //     width: 800,
          //     color: Colors.red,
          //     child: Center(
          //       child: Text(
          //         'LOG OUT',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 15,
          //           letterSpacing: 7,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
