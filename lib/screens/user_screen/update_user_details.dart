import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_training/screens/user_screen/user_cubit/user_cubit.dart';
import 'package:flutter_training/utils/widgets/custom_button.dart';
import 'package:flutter_training/utils/widgets/custom_field.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateUserDetails extends StatelessWidget {
  int? id;

  UpdateUserDetails({this.id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit=UserCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: SafeArea(
              child: Column(
                children: [
                  Text('Update User Details!', style: GoogleFonts.roboto(
                      fontSize: 34.sp, color: Color(0xff091E4A)),),
                  SizedBox(height: 20.h,),
                  Text('Update user details and give them a new identity.',
                    style: GoogleFonts.roboto(
                        fontSize: 16.sp, color: Color(0xff7C808A)),),
                  SizedBox(height: 20.h,),

                  Custom(
                    label: 'Name',
                    controller:cubit.nameController,
                  ),
                  SizedBox(height: 20.h,),

                  Custom(
                    label: 'Email',
                    controller:cubit.emailController,
                  ),
                  SizedBox(height: 20.h,),

                  Custom(
                    label: 'Phone',
                    controller:cubit.phoneController,
                  ),
                  SizedBox(height: 20.h,),
                  Custom(
                    label: 'Password',
                    controller:cubit.passwordController,
                  ),
                  SizedBox(height: 20.h,),
                  InkWell(
                      onTap: ()
                      {
                        cubit.updateUser(id);
                      },
                      child: CustomButton(text: 'Create',))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
