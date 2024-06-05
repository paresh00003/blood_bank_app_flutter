import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';



class EmergencyCallScreen extends StatefulWidget {
  const EmergencyCallScreen({Key? key});

  @override
  State<EmergencyCallScreen> createState() => _EmergencyCallScreenState();
}

class _EmergencyCallScreenState extends State<EmergencyCallScreen> {
  Future<void> sendSms(String phoneNumber, String message) async {
    String url = 'sms:$phoneNumber?body=$message';

    bool result = await canLaunchUrlString(url);

    try {
      if (result) {
        await launchUrlString(url);
      } else {
        throw Exception('Could not launch');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> dial(String contact) async {
    String url = 'tel:$contact';

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        print(true);
        await launchUrl(Uri.parse(url));
      } else {
        throw Exception('Could not launch');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Send SMS'),
              onPressed: () {

                for (int i = 0; i < 50; i++) {
                  sendSms('+919714381004', 'Hello, this is a test message');
                }
              },
            ),
            ElevatedButton(
              child: Text('Dial Number'),
              onPressed: () {
                dial('8866634508');
              },
            ),
          ],
        ),
      ),
    );
  }
}
