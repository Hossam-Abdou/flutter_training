import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/widgets/custom_button.dart';
import '../home_screen.dart';
import 'login_cubit/login_model_bloc.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, LoginModelState>(
      listener: (context,state) async{

        if(state is UserLoginSuccessState)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));

          const snackBar = SnackBar(
            content: Text('Login Successfully'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if(state is UserLoginErrorState)
        {
          const snackBar = SnackBar(
            content: Text('Password or Email is not correct'),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },

      builder: (context, state) {
    var cubit=SystemCubit.get(context);
    return Scaffold(
      body: Form(
        key: cubit.formKey,
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Welcome Back !',style: GoogleFonts.roboto(fontSize: 34.sp,color: Color(0xff091E4A)),),
                    SizedBox(height: 20.h,),
                    Padding(
                      padding:  EdgeInsets.only(left: 20.w),
                      child:  Text('Login to access your assigned tasks and personal overview.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 14,fontWeight: FontWeight.normal,color: Color(0xff7C808A)),),
                    ),
                    SizedBox(height: 20.h,),
                    Custom(
                        controller: cubit.emailController,
                        validator: (value) {
                          if(value!.isEmpty)
                          {
                            return 'The Field Can\'t Be Empty';
                          }
                          return null;
                        } ,
                        label:'Email'
                    ),
                    SizedBox(height: 20.h,),
                    Custom(
                      controller: cubit.passwordController,
                      validator: (value) {
                        if(value!.isEmpty)
                        {
                          return 'The Field Can\'t Be Empty';
                        }
                        return null;
                      } ,
                      label:'Paasword'
                    ),
                    SizedBox(height: 20.h,),

                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value)
                        {

                        }),
                        Text('Keep me Logged In',style: GoogleFonts.roboto(fontSize: 16.sp,color: Color(0xff091E4A)),),
                      ],

                    ),
                    SizedBox(height: 20.h,),
                    InkWell(
                      onTap: () {
         if(cubit.formKey.currentState!.validate()){
                          cubit.Login();
                        }                    },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        color: Color(0xff5a55ca),
                        child: Center(child: Text('Loign',style: GoogleFonts.roboto(color: Colors.white,fontSize: 14),)),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
