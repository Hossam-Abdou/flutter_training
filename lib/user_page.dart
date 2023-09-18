import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_training/screens/departments/screens/get_departments_screen.dart';
import 'package:flutter_training/screens/login/login_cubit/login_model_bloc.dart';
import 'package:flutter_training/screens/login/view/login_screen.dart';
import 'package:flutter_training/screens/user/view/get_users_screen.dart';
import 'package:flutter_training/user_tasks.dart';
import 'package:flutter_training/utils/colors/custom_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class UserPage extends StatefulWidget {

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticateCubit, AuthenticateState>(
      listener: (context, state) {
        if(state is UserLogOutSuccessState)
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

          }
      },
      builder: (context, state) {

        final GlobalKey<ScaffoldState> drawerKey = GlobalKey();
        var cubit=AuthenticateCubit.get(context);
        return Scaffold(
          key: drawerKey,
            drawer: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepartmentsScreen(),
                          ));
                    },
                    child: Text('Departments'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UsersScreen(),
                          ));
                    },
                    child: Text('Users'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserTasks(),
                          ));
                    },
                    child: Text('UserTasks'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      cubit.logOut();
                    },
                    child: const Text('Log out'),
                  ),
                ],
              ),
            ),
          backgroundColor: Color(0xffF3FAF9),
          appBar: AppBar(
            bottom: TabBar(
              
              unselectedLabelStyle: TextStyle(color: CustomColors.darkBlue,),
              controller: _tabController,
              // unselectedLabelColor: Color(0xff091E4A),
              tabs: [
                Tab(child: Row(children: [
                  Icon(Icons.person_outline_outlined,color:CustomColors.primaryButton,),
                  Text('Users',style: TextStyle(color:CustomColors.primaryButton),),
                ],)),
                Tab(child: Row(children: [
                  Icon(Icons.task,color: CustomColors.primaryButton,),
                  Text('TASKS',style: TextStyle(color: CustomColors.primaryButton,),),
                ],)),
              ],
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Today',style: TextStyle(color: CustomColors.darkBlue,fontSize: 16.sp),),
                Text('${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',style: TextStyle(color: CustomColors.greyText,fontSize: 12),)


              ],
            ),
            backgroundColor: Color(0xffF3FAF9),
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.black,
              ),
              onPressed: () {
               drawerKey.currentState?.openDrawer();

              },


            ),
            actions: [
              PopupMenuButton(
                color: Colors.white,
                position: PopupMenuPosition.under,
                icon: Container(
                  decoration: BoxDecoration(
                      color: CustomColors.primaryButton,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: const Icon(
                    Icons.add,
                  ),
                ),
                itemBuilder: (BuildContext context) {
                  return [

                    PopupMenuItem(
                      child: Text('employee', style: TextStyle(color: Colors
                          .black, fontSize: 15),),
                      value: 'option2',
                    ),
                    PopupMenuItem(
                      child: Text('Department', style: TextStyle(color: Colors
                          .black, fontSize: 15,),),
                      value: 'option2',
                    ),
                    PopupMenuItem(
                      child: Text('Tasks', style: TextStyle(color: Colors.black,
                          fontSize: 15.sp),),
                      value: 'option2',
                    ),
                    // Add more menu items as needed
                  ];
                },),
            ],

          ),
          body:TabBarView(
              controller: _tabController,
              children: [
            SafeArea(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 25.0.w),
                child:
                  ListView.builder(
                      itemCount: 3,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.h,),
                          Row(
                            children: [
                              SizedBox(

                                child: Divider(color: Color(0xff091E4A),),
                                width: 50.w,),
                              SizedBox(width: 3.w,),
                              Text('department name',style: GoogleFonts.roboto(color: Color(0xff091E4A)),)
                            ],
                          ),
                          SizedBox(height: 10.h,),

                          GridView.builder(
                            itemCount: 6,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 8/5.7,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10
                            ),

                            itemBuilder:(context, index) =>  Container(
                              height: 85.h,
                              width: 150.w,
                              padding: EdgeInsets.symmetric(vertical: 11.0.h,horizontal: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xff7C808A).withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white
                              ),
                              child: Row(
                                children: [
                                  SizedBox(child: VerticalDivider(color: Color(0xff5A55CA),thickness: 2,),height: 65.h,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Employee name',style: TextStyle(color: Color(0xff091E4A),fontSize: 16.sp,fontWeight: FontWeight.bold),),
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(3),
                                              color: Color(0xff5A55CA).withOpacity(0.1)

                                          ),
                                          height: 15.h,
                                          width: 40.w,
                                          child: Center(child: Text('Admin',style: TextStyle(color: Color(0xff5A55CA),fontSize: 10.sp),))),

                                      Row(
                                        children: [
                                          Icon(Icons.email_outlined,color: Color(0xff7C808A),),
                                          Text('user email',style: TextStyle(color: Color(0xff091E4A),fontSize: 8.sp),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.phone_outlined,color: Color(0xff7C808A),),
                                          Text('user email',style: TextStyle(color: Color(0xff091E4A),fontSize: 8.sp),),
                                        ],
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ) ,

                          )
                        ],),)
              ),
            ),
            Center(child: Text('No Tasks Yet ha'))
          ])
        );
      },
    );
  }
}
