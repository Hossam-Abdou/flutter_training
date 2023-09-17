import 'package:flutter/material.dart';
import 'package:flutter_training/screens/departments_screen/get_departments_screen.dart';
import 'package:flutter_training/screens/user_screen/get_users_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => DepartmentsScreen(),
                  ));
                }, child:  Text('Department'),),
                MaterialButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => UsersScreen(),
                  ));
                }, child:  Text('Users'),),
                MaterialButton(onPressed: () {
                }, child:  Text('----'),),
              ],
            ),
          ),
        );

  }
}
