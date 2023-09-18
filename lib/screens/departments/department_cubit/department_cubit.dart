import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/utils/end_points/urls.dart';
import 'package:meta/meta.dart';
import '../../../service/dio_helper/dio_helper.dart';
import '../../../service/sp_helper/sp_helper.dart';
import '../../../service/sp_helper/sp_keys.dart';
import '../models/department_model.dart';
import '../models/get_departments_model.dart';
import '../models/update_department.dart';

part 'department_state.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());

  static DepartmentCubit get(context) => BlocProvider.of(context);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController assignManager = TextEditingController();
  var formKey = GlobalKey<FormState>();

  DepModel? depModel;
  UpdateDepartment? updateDepartment;
  GetDepartment? getDepartment;


  CreateDep() async {
    emit(NewDepLoading());
    await DioHelper.postData(
        url: EndPoints.storeDep,
       token: "${SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)}",
        data: {
          "name": nameController.text,
        }).then((value) {
      print("1");
      if (value.data["code"] == 200 || value.data["code"] == 201) {
        depModel = DepModel.fromJson(value.data);
        print(depModel!.data!.name);
        print("2");
        emit(NewDepSucc());
      }
    }).catchError((error) {
      if (error is DioError && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(NewDepError());
    });
  }

  updateDep(id) async {
    emit(UpdateDepLoading());
    await DioHelper.postData(
        url: '${EndPoints.updateDep}/$id',
       token: "${SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)}",
        data: {
          "name": nameController.text,
        }).then((value) {
      print("1");
      if (value.data["code"] == 200 || value.data["code"] == 201) {
        depModel = DepModel.fromJson(value.data);
        print(depModel!.data!.name);
        print("2");
        nameController.clear();
        emit(UpdateDepSucc());
      }
    }).catchError((error) {
      if (error is DioError && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }
      emit(UpdateDepError());
    });
  }

  getAllDepartments() {
    DioHelper.getData(
        url: EndPoints.getDepartments,
      token:SharedPrefrenceHelper.getData(key: SharedPreferencesKeys.token)
       ).then((value) {
         print('1');
      getDepartment = GetDepartment.fromJson(value.data);
      emit(GetDepSucc());
    }).catchError((error) {
      if (error is DioError && error.response?.statusCode == 401) {
        final data = error.response?.data;
        final message = data['message'];
        print(message);
      }      emit(GetDepError());
    });
  }




}
