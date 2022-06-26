import 'package:pizza100/secrets.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class TwilioSMS {
  Future<void> getNumbers() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: false);
    }
  }

  void sendSMS(String body) {
    TwilioFlutter twilioFlutter;
    twilioFlutter = TwilioFlutter(
      accountSid: twilio_sid,
      authToken: auth_token,
      twilioNumber: mobile,
    );
    twilioFlutter.sendSMS(toNumber: mobile2, messageBody: body);
  }
}
