import 'package:blood_bank_new_one/admin_module/admin_screen/blood_banks.dart';
import 'package:flutter/material.dart';
import '../../admin_module/model/admin_class.dart';
import '../admin_screen/add-donor_screen.dart';
import '../admin_screen/view_donor_screen.dart';
import '../admin_screen/view_request_screen.dart';

class AdminDashboardScreen extends StatelessWidget {

  //final Donor selectedDonor = Donor(id: 1, name: 'John Doe', bloodGroup: 'A+');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height *
                  0.4, // 40% of screen height
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://media.istockphoto.com/id/1363584809/vector/india-world-map.jpg?s=612x612&w=0&k=20&c=wi233Ppf3BtjtiILSotnmL6bWWe1um2xh32t8sJssoY=",
                    fit: BoxFit.cover, // Cover the entire container
                  ),
                  Center(
                    child: Text(
                      'B-',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: MediaQuery.of(context).size.width * 0.32,
                        // Adjust text size based on screen width
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildSquareButton(
                    context,
                    'Add Donor',
                    AddDonorScreen(),
                  ),
                  _buildSquareButton1(
                    context,
                    'View Donors',
                    ViewDonorsScreen(),
                  ),
                  _buildSquareButton2(
                    context,
                    'Blood Request List',
                    ViewRequestsScreen(),
                  ),
                  _buildSquareButton3(
                    context,
                    'Blood Banks',
                    BloodBankListScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton(BuildContext context, String title, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade200,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Icon(
              Icons.add,
              color: Colors.red.shade900,
              size: 40,
            )),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.red.shade900,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton1(
      BuildContext context, String title, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade200,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Icon(
              Icons.search_off,
              color: Colors.red.shade900,
              size: 40,
            )),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.red.shade900,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton2(
      BuildContext context, String title, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade200,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Icon(
              Icons.list,
              color: Colors.red.shade900,
              size: 40,
            )),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.red.shade900,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton3(
      BuildContext context, String title, Widget screen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade200,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Icon(
              Icons.food_bank_rounded,
              color: Colors.red.shade900,
              size: 40,
            )),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.red.shade900,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
