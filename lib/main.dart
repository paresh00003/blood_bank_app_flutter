import 'package:blood_bank_new_one/user_module/user_main_dashboard_screen/dashboard_user_side.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'admin_module/admin_main_dashboard_screen/dashboard_admin_side.dart';
import 'database_helper/db_helper.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,


      title: 'Blood Bank Management System',

      home: HomeScreen(
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.red.shade100,


      appBar: AppBar(
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Home',style: TextStyle(

              color: Colors.white
            ),),
            IconButton(
              onPressed: () {

                SystemNavigator.pop();

              },
              icon: Icon(Icons.logout_outlined, color: Colors.red.shade900),
            )
          ],
        ),
        backgroundColor: Colors.red.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(


                child : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
                    );
                  },

                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.shade300,
                    ),
                    child: Center(
                      child: Text(
                        "Admin Module",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),


              ),
            ),


            Center(


              child : GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserDashboardScreen()),
                  );
                },

                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade300,
                  ),
                  child: Center(
                    child: Text(
                      "User Module",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),


            ),

          ],
        ),
      ),
    );
  }
}
