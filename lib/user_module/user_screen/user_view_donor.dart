import 'package:flutter/material.dart';
import '../../admin_module/model/admin_class.dart';
import '../../database_helper/db_helper.dart';
import '../../user_module/user_screen/requestblood_screen.dart';
import '../user_main_dashboard_screen/dashboard_user_side.dart';
 // Import the UserDashboardScreen

class UserViewDonorsScreen extends StatefulWidget {
  @override
  _UserViewDonorsScreenState createState() => _UserViewDonorsScreenState();
}

class _UserViewDonorsScreenState extends State<UserViewDonorsScreen> {
  late Future<List<Donor>> _donorsFuture;
  List<Donor> _filteredDonors = [];
  List<Donor> _allDonors = [];

  @override
  void initState() {
    super.initState();
    _donorsFuture = _fetchDonors();
  }

  Future<List<Donor>> _fetchDonors() async {
    List<Donor> donors = await DatabaseHelper().getDonors();
    setState(() {
      _allDonors = donors;
      _filteredDonors = donors;
    });
    return donors;
  }

  void _filterDonors(String query) {
    List<Donor> filteredList = _allDonors.where((donor) {
      return donor.name.toLowerCase().contains(query.toLowerCase()) ||
          donor.bloodGroup.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _filteredDonors = filteredList;
    });
  }

  void _requestBlood(Donor donor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Request Blood'),
        content: Text('Request blood from ${donor.name}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _submitRequest(donor);
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
        ],
      ),
    );
  }

  void _submitRequest(Donor donor) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestBloodScreen(donor: donor)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserDashboardScreen()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.red.shade100,
        appBar: AppBar(
          backgroundColor: Colors.red.shade300,
          title: Text('View Donors'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  _filterDonors(value);
                },
                decoration: InputDecoration(
                  labelText: 'Search Donors',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Donor>>(
                future: _donorsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: _filteredDonors.length,
                      itemBuilder: (context, index) {
                        Donor donor = _filteredDonors[index];
                        return Card(
                          color: Colors.red.shade50,
                          child: ListTile(
                            title: Text(donor.name),
                            subtitle: Text(donor.bloodGroup),
                            trailing: IconButton(
                              icon: Icon(Icons.bloodtype, color: Colors.red.shade300),
                              onPressed: () => _requestBlood(donor),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
