import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Custom extends StatelessWidget {
  String? label;
  final TextEditingController controller;




  Custom({required this.label,required this.controller});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'The Field Can\'t Be Empty';
        }
        return null;
      },
      cursorColor: Color(0xff091E4A),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Color(0xff091E4A)),
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
