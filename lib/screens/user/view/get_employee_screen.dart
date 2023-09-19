import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/screens/tasks/cubit/tasks_cubit.dart';
import 'package:flutter_training/screens/tasks/cubit/tasks_state.dart';
import 'package:flutter_training/screens/user/user_cubit/user_cubit.dart';
import 'package:flutter_training/screens/user/view/update_user_details.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';


import '../../../utils/colors/custom_colors.dart';
import '../../tasks/view/add_new_task.dart';
import 'add_new_user_screen.dart';


class GetEmployeeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit=TasksCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor:CustomColors.primaryButton,
            elevation: 0,
          ),
          body: cubit.getEmployeeModel==null?  Scaffold(
            body: Center(
              child: SimpleCircularProgressBar(
                progressColors:  [CustomColors.darkBlue],
                fullProgressColor: CustomColors.primaryButton,
                mergeMode: true,
                size: 25,

              ),
            ),
          ) : ListView.builder(
            itemCount:cubit.getEmployeeModel?.data?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                InkWell(
                  onTap: ()
                  {
                    print(cubit.getEmployeeModel!.data![index].id);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewTask(id: cubit.getEmployeeModel!.data![index].id),));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text('${cubit.getEmployeeModel!.data![index].name}'),
                    ),
                  ),
                ),
          ),
        );
      },
    );
  }
}
