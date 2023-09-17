import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
String? text;

CustomButton({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      color: Color(0xff5a55ca),
      child: Center(
          child: Text(
            text!,
            style: GoogleFonts.roboto(
                color: Colors.white, fontSize: 14.sp),
          )),
    );
  }
}
