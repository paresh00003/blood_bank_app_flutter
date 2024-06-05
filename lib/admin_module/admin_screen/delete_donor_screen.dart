import 'package:flutter/material.dart';

import '../model/admin_class.dart';


class DonorDetailsScreen extends StatelessWidget {
  final Donor donor;

  DonorDetailsScreen({required this.donor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text('Donor Details'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Name: ${donor.name}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Blood Group: ${donor.bloodGroup}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }


}
