import 'package:flutter/material.dart';

import '../model/banks.dart';

class BloodBankListScreen extends StatelessWidget {
  final List<BloodBank> bloodBanks = [
    BloodBank(
      name: 'Red Cross Blood Bank',
      address: '123 Main Adajan, Surat, India',
      phone: '+2334567890',
    ),
    BloodBank(
      name: 'Tops Blood Bank',
      address: '456 Ring Road, Surat, India',
      phone: '+3287654321',
    ),
    BloodBank(
      name: 'Central Blood Bank',
      address: '789 Talaja, Bhavanagar, India',
      phone: '+1122334455',
    ),
    BloodBank(
      name: 'Regional Blood Center',
      address: '321 Vesu, Surat, India',
      phone: '+9988776655',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade100,
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text('Blood Banks'),
      ),
      body: ListView.builder(
        itemCount: bloodBanks.length,
        itemBuilder: (context, index) {
          var bloodBank = bloodBanks[index];
          return Card(
            child: ListTile(
              title: Text(bloodBank.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(bloodBank.address),
                  Text(bloodBank.phone),
                ],
              ),
              onTap: () {
            
              },
            ),
          );
        },
      ),
    );
  }
}
