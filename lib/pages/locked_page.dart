import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ussd_service/ussd_service.dart';

class LockedPage extends StatelessWidget {
  const LockedPage({super.key});
  void _launchDialer([String? phoneNumber]) async {
    final Uri _phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(_phoneLaunchUri)) {
      await launchUrl(_phoneLaunchUri);
    } else {
      print('Could not launch $_phoneLaunchUri');
    }
  }

  makeMyRequest() async {
    int subscriptionId = 1; // sim card subscription Id
    String code = "9059078712"; // ussd code payload
    try {
      String ussdSuccessMessage = await UssdService.makeRequest(subscriptionId, code);
      print("succes! message: $ussdSuccessMessage");
    } on PlatformException catch (e) {
      print("error! code: ${e.code} - message: ${e.message}");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 20),
            const Text(
              'Your device was locked as you have not paid your EMI',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(height: 10),
            const Text('Tejpal Jadav to unlock',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            Container(height: 10),
            GestureDetector(onTap:() async {
              final permission = await Permission.phone.request();
              if(permission.isGranted){
                makeMyRequest();
              }
            },child: const Text('+91 9876543210')),
            Container(height: 10),
            OutlinedButton(
                onPressed: () {
                  _launchDialer();
                }, child: const Text("Emergency Call")),
            Container(height: 10),
            Spacer(
              flex: 1,
            ),
            Text('scan and pay using qr'),
            QrImageView(
              data: 'Tejpal Jadav to unlock +91 9876543210',
              version: QrVersions.auto,
              size: 300.0,
            ),
            Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    ));
  }
}
