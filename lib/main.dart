import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_training/screens/home_screen.dart';
import 'package:flutter_training/screens/login_model/login_cubit/login_model_bloc.dart';
import 'package:flutter_training/screens/login_model/login_screen.dart';
import 'package:flutter_training/service/dio_helper/dio_helper.dart';
import 'package:flutter_training/service/sp_helper/sp_keys.dart';

import 'service/sp_helper/sp_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await SharedPrefrenceHelper.init();
  Widget? widget;
  if(SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)!=null){
    widget=HomeScreen();
  }else{
    widget=LoginScreen();
  }
  runApp(MyApp(startWidget:widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;


  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocProvider(
            create: (context) => SystemCubit(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: startWidget
            ),
          );
        }
    );
  }
}