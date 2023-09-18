import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/utils/end_points/urls.dart';
import '../../../service/dio_helper/dio_helper.dart';
import '../../../service/sp_helper/sp_helper.dart';
import '../../../service/sp_helper/sp_keys.dart';
import '../model/get_user_model.dart';
import '../model/update_user_model.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController depNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState>drawerKey =GlobalKey<ScaffoldState>();

  UpdateUserModel? updateUserModel;
  GetUserModel? getUserModel;

  AddUser() async {
    emit(NewUserLoading());
    await DioHelper.postData(
        url: EndPoints.addUser,
       token: "${SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)}",
        data: {
          "name": nameController.text,
          "email": emailController.text,
          "phone": int.parse(phoneController.text),
          "password": passwordController.text,
          'user_type': 1
        }).then((value) {
      if (value.data["code"] == 200 || value.data["code"] == 201) {
        // addUserModel = AddUserModel.fromJson(value.data);
        getAllUsers();
        emit(NewUserSucc());
      }
    }).catchError((error) {
      if (error is DioException && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(NewUserError());
    });
  }

  updateUser(id) async {
    emit(UpdateUserLoading());
    await DioHelper.postData(
        url: '${EndPoints.updateUser}/$id',
       token: "${SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)}",
        data: {
          "name": nameController.text,
          "email": emailController.text,
          "phone": int.parse(phoneController.text),
          "password": passwordController.text,
          'user_type':selectedCheckbox,
          'user_status':0
        }).then((value) {

      if (value.data["code"] == 200 || value.data["code"] == 201) {
        updateUserModel = UpdateUserModel.fromJson(value.data);
        print(updateUserModel!.data!.name);
        print(updateUserModel!.data!.userType);
        getAllUsers();

        emit(UpdateUserSucc());
      }
    }).catchError((error) {
      if (error is DioError && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(UpdateUserError());
    });
  }
  getAllUsers() {
    DioHelper.getData(
        url: EndPoints.getUsers,
      token:SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)
       ).then((value) {
         print('1');
      getUserModel = GetUserModel.fromJson(value.data);
      emit(GetUserSucc());
    }).catchError((error) {
      if (error is DioError && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }      emit(GetUserError());
    });
  }

  dynamic selectedCheckbox=0;
  void updateSelectedCheckbox(value) {
    selectedCheckbox=value;
    emit(mn());
  }




}
