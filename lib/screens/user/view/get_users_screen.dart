import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_training/screens/user/user_cubit/user_cubit.dart';
import 'package:flutter_training/screens/user/view/update_user_details.dart';


import '../../../utils/colors/custom_colors.dart';
import 'add_new_user_screen.dart';


class UsersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
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
            backgroundColor:  CustomColors.darkBlue,
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
