import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/service/secure_storage.dart';
import 'package:flutter_training/utils/end_points/urls.dart';
import 'package:meta/meta.dart';
import '../../../service/dio_helper/dio_helper.dart';
import '../../../service/sp_helper/sp_helper.dart';
import '../../../service/sp_helper/sp_keys.dart';
import '../model/authentication_model.dart';
part 'login_model_state.dart';

class AuthenticateCubit extends Cubit<AuthenticateState> {
  AuthenticateCubit() : super(LoginModelInitial());

  static AuthenticateCubit get(context) => BlocProvider.of(context);
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
      print(SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token));
      print("hosaam");

    }).catchError((error) {
      emit(UserLoginErrorState());
      print(error);
    });
  }

  logOut()async {
    emit(UserLogOutLoadingState());
    DioHelper.postData(
        url: EndPoints.logOut,
        token: SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token),
        data: {
    }
    ).then((value) {
      print('1');
      SharedPrefrenceHelper.removeData(key: SharedPreferencesKeys.token);
      print('loggg out');
      emit(UserLogOutSuccessState());
    }).catchError((error) {
      print('error log out ');
      emit(UserLogOutErrorState());
    });
  }
  bool authenticateCheckBox=false;
  void changeCheck()
  {
    authenticateCheckBox=!authenticateCheckBox;
  emit(CheckBoxChangeState());
  }




}
