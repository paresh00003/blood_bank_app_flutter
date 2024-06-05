import 'package:flutter/material.dart';
import '../../admin_module/model/admin_class.dart';
import '../../admin_module/model/user_class.dart';
import '../../database_helper/db_helper.dart';

class RequestBloodScreen extends StatefulWidget {
  final Donor donor;

  RequestBloodScreen({required this.donor});

  @override
  _RequestBloodScreenState createState() => _RequestBloodScreenState();
}

class _RequestBloodScreenState extends State<RequestBloodScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text('Request Blood Donation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Donor: ${widget.donor.name}'),
              SizedBox(height: 20),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(

                  border: OutlineInputBorder(),
                    labelText: 'Quantity (in units)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
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
                        _submitRequest();
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
                          "Submit Request",
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

  void _submitRequest() async {
    String name = widget.donor.name;
    String bloodGroup = widget.donor.bloodGroup;
    int quantity = int.parse(_quantityController.text);
    int donorId = widget.donor.id!;

    // Create a new UserRequest object without specifying an ID
    UserRequest request = UserRequest(
      donorId: donorId,
      name: name,
      bloodGroup: bloodGroup,
      quantity: quantity,
    );

    // Add the user request to the database
    int? requestId = await DatabaseHelper().addUserRequest(request);

    if (requestId != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Blood donation request submitted successfully')),
      );

      _quantityController.clear();
      Navigator.of(context).pop(); // Go back to the previous screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit blood donation request')),
      );
    }
  }
}
