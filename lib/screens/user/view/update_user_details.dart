import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_training/utils/widgets/custom_button.dart';
import 'package:flutter_training/utils/widgets/custom_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/colors/custom_colors.dart';
import '../user_cubit/user_cubit.dart';
import 'get_users_screen.dart';


class UpdateUserDetails extends StatelessWidget {
  int? id;

  UpdateUserDetails({this.id});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if(state is NewUserSucc)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => UsersScreen(),));
        }
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
                      fontSize: 34.sp, color: CustomColors.darkBlue),),
                  SizedBox(height: 20.h,),
                  Text('Update user details and give them a new identity.',
                    style: GoogleFonts.roboto(
                        fontSize: 16.sp, color: CustomColors.greyText),),
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
                  Row(
                    children: [
                      Checkbox(
                        value: cubit.selectedCheckbox == 0,
                        activeColor: CustomColors.primaryButton,
                        onChanged: (val) {
                            cubit.updateSelectedCheckbox(0);
                        },
                        shape: OvalBorder(),
                      ),
                      Text('admin'),

                      Checkbox(
                        value: cubit.selectedCheckbox == 1,
                        activeColor: CustomColors.primaryButton,
                        onChanged: (val) {
                          cubit.updateSelectedCheckbox(1) ;
                        },
                        shape: OvalBorder(),
                      ),
                      Text('manager'),

                      Checkbox(
                        value: cubit.selectedCheckbox == 2,
                        activeColor:CustomColors.primaryButton,
                        onChanged: (val) {
                          cubit.updateSelectedCheckbox(2);
                        },
                        shape: OvalBorder(),
                      ),
                      Text('employee'),

                    ],
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
