import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {

  final String hintText;
  final Widget? icon;
   bool obscure;
   TextInputType? type;

  TextEditingController ctrl=TextEditingController();



   TextFields({
    super.key,
     required this.ctrl,required this.hintText, this.icon,this.obscure=false, this.type

  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      controller: ctrl,
      keyboardType: type,
      decoration: InputDecoration(
        suffixIcon: icon,
        hintText:hintText ,

          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(10))
          )
      ),
    );
  }
}
