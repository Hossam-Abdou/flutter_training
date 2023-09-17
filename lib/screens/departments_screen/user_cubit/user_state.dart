part of 'user_cubit.dart';

@immutable
abstract class DepartmentState {}

class DepartmentInitial extends DepartmentState {}


class NewDepLoading extends DepartmentState {}
class NewDepSucc extends DepartmentState {}
class NewDepError extends DepartmentState {}


class UpdateDepLoading extends DepartmentState {}
class UpdateDepSucc extends DepartmentState {}
class UpdateDepError extends DepartmentState {}


class GetDepLoading extends DepartmentState {}
class GetDepSucc extends DepartmentState {}
class GetDepError extends DepartmentState {}
