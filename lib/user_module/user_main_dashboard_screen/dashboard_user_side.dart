import 'package:flutter/material.dart';
import '../../main.dart';
import '../user_screen/emergenacy_screen.dart';
import '../user_screen/user_view_donor.dart';

class UserDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('User Dashboard'),
            IconButton(
              onPressed: () {

                Navigator.pop(context); // Close the drawer
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<dynamic> route) => false,
                );
              },
              icon: Icon(Icons.logout_outlined, color: Colors.red.shade900),
            )
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.red.shade50,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      'https://img.freepik.com/free-vector/human-blood-donate-white-background_1308-110986.jpg?size=626&ext=jpg',
                      // Replace with your image URL
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 2,
                    child: Text(
                      'Blood Bank',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.people, color: Colors.red),
              title: Text(
                'User View Donors',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserViewDonorsScreen()),
                );
              },
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: Colors.red.shade100,
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.red),
              title: Text(
                'Emergency Call',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmergencyCallScreen()),
                );
              },
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: Colors.red.shade100,
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.red),
              title: Text(
                'About Us',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to About Us screen or show a dialog
              },
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: Colors.red.shade100,
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.red),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to Settings screen or show a dialog
              },
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: Colors.red.shade100,
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined, color: Colors.red),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (Route<dynamic> route) => false,
                ); // Navigate to HomeScreen
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to the User Side Drawer Screen'),
      ),
    );
  }
}
