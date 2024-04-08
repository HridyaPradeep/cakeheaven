import 'package:cakeheaven/Screens/registeration.dart';
import 'package:cakeheaven/TextField.dart';
import 'package:cakeheaven/adminhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../Adminapp.dart';
import 'homescreen.dart';

class Logi extends StatefulWidget {
  const Logi({super.key});

  @override
  State<Logi> createState() => _LogiState();
}

class _LogiState extends State<Logi> {
  loggData({required email, required password}) async {
    try {
      final strore = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (strore.user != null) {

        if(FirebaseAuth.instance.currentUser!.uid=="TPZRSIqZOhSp0UrJBcQfJBYvUus1"){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return AdminHome();
          }));
        }


        else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Homis(),));
        }


      }

    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: 'Enter invalid email',
            backgroundColor: Colors.red,
            fontSize: 15);
      }
      if (error.code == 'INVALID_LOGIN_CREDENTIALS ') {
        Fluttertoast.showToast(
            msg: 'wrong details', backgroundColor: Colors.red, fontSize: 15);
      }
      if (error.code == 'channel-error') {
        Fluttertoast.showToast(
            msg: 'please fill all fields',
            backgroundColor: Colors.red,
            fontSize: 15);
      }

      print(error);
    }
  }

  TextEditingController email1ctrl = TextEditingController();
  TextEditingController passwrd1ctrl = TextEditingController();
  bool seek = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent.shade200,
        title: Text(""),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Lottie.asset(
                'asset/lottielogin.json',
                height: 100,
                fit: BoxFit.cover,
                width: 230,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            TextField(
              controller: email1ctrl,
              decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true),
            ),
            SizedBox(
              height: 26,
            ),
            TextField(
              controller: passwrd1ctrl,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: (){
                loggData(email: email1ctrl.text, password: passwrd1ctrl.text);
              },
              child: Container(
                height: 50,
                width: 330,
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.all(Radius.circular(70))),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {
                        loggData(email: email1ctrl.text, password: passwrd1ctrl.text);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Regis(),
                        ));
                      },
                      child: Center(
                        child: Text('Register now?'),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
