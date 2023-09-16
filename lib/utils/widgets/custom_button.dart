import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custom extends StatelessWidget {
  String? label;
  final TextEditingController controller;
  final String? Function(String?)? validator;




  Custom({required this.label,required this.controller,this.validator});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff091E4A)),

        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff091E4A),),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff091E4A),),
          ),

      ),
    );
  }
}
