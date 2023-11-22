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
import 'location.dart';


void _sendSMS(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
    return Future.error(onError);
  });
  print(_result);
}

Future<String> getContact1() async {
  final lst = await DatabaseHelper.getData();
  return lst[2];
}

Future<String> getContact2() async {
  final lst = await DatabaseHelper.getData();
  if (lst[3] == "0") {
    return "-";
  } else {
    return lst[3];
  }
}

Future<String> getContact3() async {
  final lst = await DatabaseHelper.getData();
  if (lst[4] == "0") {
    return "-";
  } else {
    return lst[4];
  }
}

class ButtonPage extends StatefulWidget {
  final Users? user_;
  const ButtonPage({Key? key, this.user_}) : super(key: key);

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  String message = "You have an alert from SheGuard!";
  


//_sendSMS(message, recipents);
/*String _result = await sendSMS(message: message, recipients: recipents, sendDirect: true)
        .catchError((onError) {
      print(onError);
    });
print(_result); */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.pink.shade50,
      body:
          Center(
            
        child: ElevatedButton(
          onPressed: () async {
            /*String _result = await sendSMS(
                    message: message, recipients: recipents, sendDirect: true)
                .catchError((onError) {
              print(onError);
            });
            print(_result);*/
            String contact1="";
            String contact2="";
            String contact3="";
            contact1=await getContact1();
            contact2=await getContact2();
            contact3=await getContact3();
            List<String> recipients2=[contact1];
            if(contact2=="-"&&contact3!="-"){
              recipients2.add(contact3);
            }
            else if(contact2!="-"&&contact3=="-"){
              recipients2.add(contact2);
            }
            else if(contact2!="-"&&contact3!="-"){
              recipients2.add(contact2);
              recipients2.add(contact3);
            }
            _sendSMS(message, recipients2);
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 200),
            shape: const CircleBorder(),
            backgroundColor: Colors.red,
          ),
          child: const Text(
            'Alert',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink.shade500,
        fixedColor: Colors.white,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ButtonPage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
        selectedIconTheme: IconThemeData(color: Colors.black),
        unselectedIconTheme: IconThemeData(color: Colors.black),
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),
      ),
    );
  }
}
