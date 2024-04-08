import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Adminapp.dart';
import 'Screens/login.dart';
import 'adminDelect.dart';
import 'adminbookings.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerHeader(child: Column(
          children: [
            DrawerHeader(child: InkWell(
              onTap: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Logi(),
                ));
              },
              child: Container(
                height: 20,
                width: 800,
                color: Colors.red,
                child: Center(child: Text("log out"),),
              ),
            ))
          ],
        )),
      ),
      appBar: AppBar(

        title: Text(
          "Admin Screen",
          style: TextStyle(
            decorationThickness: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return Admis();
                    },));
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "Addings",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                        color: Colors.purpleAccent.shade100,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(21),
                            bottomRight: Radius.circular(21))),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return Delectpage();
                    },
                  ));
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "delecting",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.purpleAccent.shade100,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(21),
                          bottomRight: Radius.circular(21))),
                ),

              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Column(
            children: [
              Container(
                child: Center(
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return AdminBooking();
                        },
                      ));
                    },
                    child: Text(
                      " My Bookings",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                    color: Colors.purpleAccent.shade100,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(21),
                        bottomRight: Radius.circular(21))),
              ),
            ],
          )
        ],
      ),

    );
  }
}
