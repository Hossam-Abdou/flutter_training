import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/utils/colors/custom_colors.dart';

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
      cursorColor: CustomColors.darkBlue,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color:CustomColors.darkBlue),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.darkBlue),

        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.darkBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.darkBlue,),
          ),

      ),
    );
  }
}
