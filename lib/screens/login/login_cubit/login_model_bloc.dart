import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/utils/end_points/urls.dart';
import 'package:meta/meta.dart';

import '../../../model/authentication_model.dart';
import '../../../service/dio_helper/dio_helper.dart';
import '../../../service/sp_helper/sp_helper.dart';
import '../../../service/sp_helper/sp_keys.dart';

part 'login_model_state.dart';

class SystemCubit extends Cubit<LoginModelState> {
  SystemCubit() : super(LoginModelInitial());

  static SystemCubit get(context) => BlocProvider.of(context);
TextEditingController emailController= TextEditingController();
TextEditingController passwordController= TextEditingController();
  var formKey=GlobalKey<FormState>();

  AuthenticationModel? authentication;


  Login()async {
    emit(UserLoginLoadingState());
    DioHelper.postData(
        url: EndPoints.LogIn,
        data: {
      "email": emailController.text,
      "password": passwordController.text
    }).then((value) {
      authentication = AuthenticationModel.fromJson(value.data);
      if (authentication!.code == 200) {
        print( authentication!.data!.token);
        emit(UserLoginSuccessState());
      }
      SharedPrefrenceHelper.saveData(
          key: SharedPreferencesKeys.token,
          value: authentication!.data!.token);
      print("hosaam");
print(SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token));
print("hosaam");
      emailController.clear();
      passwordController.clear();
    }).catchError((error) {
      emit(UserLoginErrorState());
      print(error);
    });
  }

  logOut()async {
    emit(UserLogOutLoadingState());
    DioHelper.postData(url: EndPoints.logOut, data: {
    }).then((value) {
      print('loggg out');
    }).catchError((error) {
      emit(UserLogOutErrorState());
    });
  }




}
