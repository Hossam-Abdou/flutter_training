import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/screens/departments_screen/user_cubit/user_cubit.dart';
import 'package:flutter_training/screens/user_screen/add_new_user_screen.dart';
import 'package:flutter_training/screens/user_screen/model/update_department.dart';
import 'package:flutter_training/screens/departments_screen/update_department.dart';
import 'package:flutter_training/screens/user_screen/update_user_details.dart';
import 'package:flutter_training/screens/user_screen/user_cubit/user_cubit.dart';


class UsersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=UserCubit.get(context);
        return Scaffold(
          body: ListView.builder(
            itemCount:cubit.getUserModel?.data?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                InkWell(
                  onTap: ()
                  {
                    print(cubit.getUserModel!.data![index].id);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUserDetails(id: cubit.getUserModel!.data![index].id),));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text('${cubit.getUserModel!.data![index].name}'),
                    ),
                  ),
                ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor:  Color(0xff091E4A),
            onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUserScreen(),));
            },
            child: Icon(Icons.add),

          ),
        );
      },
    );
  }
}
