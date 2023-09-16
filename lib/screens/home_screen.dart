import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/screens/login_model/login_cubit/login_model_bloc.dart';
import 'package:flutter_training/screens/login_model/login_screen.dart';
import 'package:flutter_training/service/sp_helper/sp_keys.dart';

import '../service/sp_helper/sp_helper.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemCubit, LoginModelState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(onPressed: () {
                  SystemCubit.get(context).logOut();
                  SharedPrefrenceHelper.removeData(
                      key: SharedPreferencesKeys.token);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                }, child: Text('LogOut'),)
              ],
            ),
          ),
        );
      });
  }
}
