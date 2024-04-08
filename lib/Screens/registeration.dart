import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../TextField.dart';
import 'login.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  TextEditingController passwrdctrl = TextEditingController();
  TextEditingController confirmctrl = TextEditingController();
  TextEditingController numberctrl = TextEditingController();

  bool seek = false;



  RegistrationData({required email, required password}) async {
    try {
      var userDetials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseFirestore.instance.collection('Users').doc(userDetials.user!.uid).collection('details').add({
        'name':namectrl.text,
        'email':emailctrl.text,
        'phone':numberctrl.text,
        "image":"https://darlingquote.com/wp-content/uploads/2021/03/2.png"
      });
      if(userDetials.user!=null){

      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return Logi();
      }));
    } on FirebaseAuthException catch (error) {
      print(error.code);
      if (error.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Enter invalid email',
            backgroundColor: Colors.red,
            fontSize: 15);
      }
      if (error.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'password should atleast 6 character',
            backgroundColor: Colors.red,
            fontSize: 15);
      }
      if(error.code=='channel-error'){
        Fluttertoast.showToast(msg: 'please fill all fields',backgroundColor: Colors.red,
        fontSize: 15);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,

          children: [

            TextFields(
              hintText: 'Enter your name',
              icon: Icon(Icons.person),
              ctrl: namectrl,
            ),
            SizedBox(
              height: 20,
            ),
            TextFields(
              icon: Icon(Icons.email_outlined),
              hintText: 'Enter your email',
              ctrl: emailctrl,
            ),
            SizedBox(
              height: 20,
            ),
            TextFields(
                obscure: seek,
                ctrl: passwrdctrl,
                hintText: 'Enter your password',
                icon: seek == true
                    ? IconButton(
                        onPressed: () {
                          seek = !seek;
                          setState(() {});
                        },
                        icon: Icon(Icons.visibility_off),
                      )
                    : IconButton(
                        onPressed: () {
                          seek = !seek;
                          setState(() {});
                        },
                        icon: Icon(Icons.visibility),
                      )

                // icon: Icon(Icons.remove_red_eye),

                ),
            SizedBox(
              height: 20,
            ),
            TextFields(
              obscure: true,
              hintText: 'confirm Your password',
              ctrl: confirmctrl,
              icon: Icon(Icons.remove_red_eye),
            ),
            SizedBox(
              height: 20,
            ),
            TextFields(
              type: TextInputType.phone,
              icon: Icon(Icons.phone),
              hintText: 'Enter your mobnumber',
              ctrl: numberctrl,
            ),
            ElevatedButton(onPressed: (){
              RegistrationData(email: emailctrl.text,password: passwrdctrl.text);
            }, child: Text('press'))

          ],
        ),
      ),
    );
  }
}
