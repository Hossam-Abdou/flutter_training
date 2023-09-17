import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/screens/departments_screen/update_department.dart';

import 'create_department.dart';
import 'department_cubit/department_cubit.dart';

class DepartmentsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DepartmentCubit, DepartmentState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=DepartmentCubit.get(context);
        return Scaffold(
          body: ListView.builder(
            itemCount:cubit.getDepartment?.data?.length ,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
            InkWell(
              onTap: ()
              {
                print(cubit.getDepartment!.data![index].id);
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateDepartmentScreen(id: cubit.getDepartment!.data![index].id),));
              },
              child: Card(
                child: ListTile(
                  title: Text('${cubit.getDepartment!.data![index].name}'),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor:  Color(0xff091E4A),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateDepartmentScreen(),));
            },
            child: Icon(Icons.add),

          ),
        );
      },
    );
  }
}
