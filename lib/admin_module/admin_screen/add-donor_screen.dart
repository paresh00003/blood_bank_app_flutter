import 'package:flutter/material.dart';


import '../../database_helper/db_helper.dart';
import '../model/admin_class.dart';

class AddDonorScreen extends StatefulWidget {
  @override
  _AddDonorScreenState createState() => _AddDonorScreenState();
}

class _AddDonorScreenState extends State<AddDonorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text('Add Donor'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(



            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,

                  decoration: InputDecoration(


                      labelText: 'Name',

                    border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  controller: _bloodGroupController,
                  decoration: InputDecoration(labelText: 'Blood Group',
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a blood group';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(


                   child : GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _addDonor();
                        }
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
                            "Submit",
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
      ),
    );
  }

  void _addDonor() async {
    String name = _nameController.text;
    String bloodGroup = _bloodGroupController.text;

    Donor donor = Donor(name: name, bloodGroup: bloodGroup);

    int? donorId = await DatabaseHelper().addDonor(donor);

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(content: Text('Donor added successfully')

      ),
    );

    print('Added donor with ID: $donorId');

    _nameController.clear();
    _bloodGroupController.clear();
  }
}
