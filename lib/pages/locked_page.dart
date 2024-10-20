import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:mdm_client/configurations/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class LockedPage extends StatelessWidget {
  const LockedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: kPadding * 3),
              const Text(
                'Your device was locked as you have not paid your EMI',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kPadding * 2),
              const Text(
                'आपका मोबाइल लॉक कर दिया गया है ॰ लॉक खुलवाने के लिए कॉल करें',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kPadding * 2),
              const Text('Call Tejpal Jadav to unlock', textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
              const SizedBox(height: kPadding * 2),
              ListView.builder(
                itemCount: supportPhoneNumbers.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return _PhoneCallWidget(
                    phoneNumber: supportPhoneNumbers[index],
                  );
                },
              ),
              const SizedBox(height: kPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneCallWidget extends StatelessWidget {
  final String phoneNumber;

  const _PhoneCallWidget({required this.phoneNumber});

  Future<void> initiateCall(String phoneNumber) async {
    AndroidIntent intent = AndroidIntent(
      action: androidCallIntent,
      data: Uri(scheme: 'tel', path: phoneNumber).toString(),
    );
    await intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final permission = await Permission.phone.request();
        if (permission.isGranted) {
          initiateCall(phoneNumber);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Text(
          phoneNumber,
          style: const TextStyle(fontSize: 20, color: Colors.blue),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
