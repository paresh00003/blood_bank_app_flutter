import 'package:flutter/material.dart';
import '../../database_helper/db_helper.dart';
import '../model/admin_class.dart';

import 'delete_donor_screen.dart';
import 'update_donor_screen.dart';

class ViewDonorsScreen extends StatefulWidget {
  @override
  _ViewDonorsScreenState createState() => _ViewDonorsScreenState();
}

class _ViewDonorsScreenState extends State<ViewDonorsScreen> {
  late Future<List<Donor>> _donorsFuture;

  @override
  void initState() {
    super.initState();
    _donorsFuture = _fetchDonors();
  }

  Future<List<Donor>> _fetchDonors() async {
    return DatabaseHelper().getDonors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text('View Donors'),
      ),
      body: FutureBuilder<List<Donor>>(
        future: _donorsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Donor> donors = snapshot.data!;
            return ListView.builder(
              itemCount: donors.length,
              itemBuilder: (context, index) {
                Donor donor = donors[index];
                return Card(
                  color: Colors.orange.shade50,
                  child: ListTile(
                    title: Text(donor.name),
                    subtitle: Text(donor.bloodGroup),
                    trailing: PopupMenuButton<String>(
                      color: Colors.red.shade100,
                      onSelected: (value) {
                        if (value == 'update') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateDonorScreen(donor: donor),
                            ),
                          );
                        } else if (value == 'delete') {
                          _confirmDeleteDonor(context, donor.id!);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'update',
                          child: Text('Update'),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonorDetailsScreen(donor: donor),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _confirmDeleteDonor(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this donor?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _deleteDonor(context, id);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _deleteDonor(BuildContext context, int id) async {
    await DatabaseHelper().deleteDonor(id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Donor deleted successfully')),
    );

    // Refresh the list after deletion
    setState(() {
      _donorsFuture = _fetchDonors();
    });
  }
}
