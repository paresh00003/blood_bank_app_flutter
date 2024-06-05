import 'package:flutter/material.dart';
import '../../database_helper/db_helper.dart';
import '../model/admin_class.dart';

class UpdateDonorScreen extends StatefulWidget {
  final Donor donor;

  UpdateDonorScreen({required this.donor});

  @override
  _UpdateDonorScreenState createState() => _UpdateDonorScreenState();
}

class _UpdateDonorScreenState extends State<UpdateDonorScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bloodGroupController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.donor.name);
    _bloodGroupController = TextEditingController(text: widget.donor.bloodGroup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text('Update Donor'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name'),
              ),
          
          
              SizedBox(
          
                height: 20,
              ),
          
          
              TextFormField(
                controller: _bloodGroupController,
                decoration: InputDecoration(
          
                  border: OutlineInputBorder(),
                    labelText: 'Blood Group'),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
          
          
                  child : GestureDetector(
                    onTap: () {
                      _updateDonor();
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
                          "Update",
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
            ],
          ),
        ),
      ),
    );
  }

  void _updateDonor() async {
    String name = _nameController.text;
    String bloodGroup = _bloodGroupController.text;

    Donor updatedDonor = Donor(
      id: widget.donor.id,
      name: name,
      bloodGroup: bloodGroup,
    );

    await DatabaseHelper().updateDonor(updatedDonor);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Donor updated successfully')),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bloodGroupController.dispose();
    super.dispose();
  }
}
