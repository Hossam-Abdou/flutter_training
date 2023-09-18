import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_training/screens/login/login_cubit/login_model_bloc.dart';
import 'package:flutter_training/screens/login/view/login_screen.dart';
import 'package:flutter_training/screens/user/user_cubit/user_cubit.dart';
import 'package:flutter_training/service/dio_helper/dio_helper.dart';
import 'package:flutter_training/service/sp_helper/sp_keys.dart';
import 'package:flutter_training/user_page.dart';
import 'bloc_observer.dart';
import 'screens/departments/department_cubit/department_cubit.dart';
import 'service/sp_helper/sp_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await SharedPrefrenceHelper.init();
  Widget? widget;
  if(SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)!=null){
    widget=UserPage();
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
          return MultiBlocProvider(
            providers: [
              BlocProvider(create:(context) => AuthenticateCubit(),),
              BlocProvider(create:(context) => DepartmentCubit()..getAllDepartments(),),
              BlocProvider(create:(context) => UserCubit()..getAllUsers(),),

          ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home:startWidget
            ),
          );
        }
    );
  }
}