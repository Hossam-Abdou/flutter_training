import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/screens/user_screen/model/get_user_model.dart';

import 'package:flutter_training/screens/user_screen/model/update_user_model.dart';
import 'package:flutter_training/utils/end_points/urls.dart';
import '../../../service/dio_helper/dio_helper.dart';
import '../../../service/sp_helper/sp_helper.dart';
import '../../../service/sp_helper/sp_keys.dart';
import '../../user_screen/model/get_departments_model.dart';
import '../model/add_user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static UserCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  AddUserModel? addUserModel;
  UpdateUserModel? updateUserModel;
  GetUserModel? getUserModel;

  AddUser() async {
    emit(NewUserLoading());
    await DioHelper.postData(
        url: EndPoints.addUser,
       token: "${SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)}",
        data: {
          "name": nameController.text,
        }).then((value) {
      print("1");
      if (value.data["code"] == 200 || value.data["code"] == 201) {
        addUserModel = AddUserModel.fromJson(value.data);
        print(addUserModel!.data!.name);
        print("2");
        emit(NewUserSucc());
      }
    }).catchError((error) {
      if (error is DioError && error.response?.statusCode == 401) {
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
        }).then((value) {
      print("1");
      if (value.data["code"] == 200 || value.data["code"] == 201) {
        updateUserModel = UpdateUserModel.fromJson(value.data);
        print(updateUserModel!.data!.name);
        print("2");
        nameController.clear();
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




}
