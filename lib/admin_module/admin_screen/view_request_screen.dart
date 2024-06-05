import 'package:flutter/material.dart';
import '../../database_helper/db_helper.dart';
import '../model/admin_class.dart';
import '../model/user_class.dart';

class ViewRequestsScreen extends StatefulWidget {
  @override
  _ViewRequestsScreenState createState() => _ViewRequestsScreenState();
}

class _ViewRequestsScreenState extends State<ViewRequestsScreen> {
  late Future<List<UserRequest>> _requestsFuture;

  @override
  void initState() {
    super.initState();
    _requestsFuture = _fetchRequests();
  }

  Future<List<UserRequest>> _fetchRequests() async {
    try {
      return await DatabaseHelper().getUserRequests();
    } catch (e) {
      print('Error fetching requests: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text('Blood Requests List'),
      ),
      body: FutureBuilder<List<UserRequest>>(
        future: _requestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No requests found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                UserRequest request = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(request.name),
                    subtitle: Text('Blood Group: ${request.bloodGroup}, Quantity: ${request.quantity} units'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red.shade900),
                      onPressed: () {
                        _confirmDeleteRequest(context, request.id!);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _confirmDeleteRequest(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this request?'),
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
              _deleteRequest(id);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _deleteRequest(int id) async {
    try {
      await DatabaseHelper().deleteUserRequest(id);
      setState(() {
        _requestsFuture = _fetchRequests();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request deleted successfully')),
      );
    } catch (e) {
      print('Error deleting request: $e');
    }
  }
}
