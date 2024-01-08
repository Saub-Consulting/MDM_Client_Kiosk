import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LockedPage extends StatelessWidget {
  const LockedPage({super.key});
  void _launchDialer([String? phoneNumber]) async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(phoneLaunchUri)) {
      await launchUrl(phoneLaunchUri);
    } else {
      print('Could not launch $phoneLaunchUri');
    }
  }

  initiateCall() async {
    AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.CALL',
      data: Uri(scheme: 'tel', path: '7014261395').toString(),
    );
    await intent.launch();
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
            const Text('Call Tejpal Jadav to unlock', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            Container(height: 10),
            GestureDetector(
              onTap: () async {
                final permission = await Permission.phone.request();
                if (permission.isGranted) {
                  initiateCall();
                }
              },
              child: const Text(
                '+91 9876543210',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            Container(height: 10),
            OutlinedButton(
                onPressed: () {
                  _launchDialer();
                },
                child: const Text("Emergency Call")),
            Container(height: 10),
            const Spacer(
              flex: 1,
            ),
            const Text('scan and pay using qr'),
            QrImageView(
              data: 'Tejpal Jadav to unlock +91 9876543210',
              version: QrVersions.auto,
              size: 300.0,
            ),
            const Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    ));
  }
}
