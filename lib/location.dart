import 'package:flutter_sms/flutter_sms.dart';
import '../models/db.dart';
import '../services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import '../models/db.dart';
import '../services/db_helper.dart';
import 'acc.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';



class LocationPage extends StatefulWidget {
  final Users? user;
  const LocationPage({Key? key, this.user}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String message = "This is a test message!";
  List<String> recipents = ["6360965158"];

//_sendSMS(message, recipents);
/*String _result = await sendSMS(message: message, recipients: recipents, sendDirect: true)
        .catchError((onError) {
      print(onError);
    });
print(_result); */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,);
  }
}
