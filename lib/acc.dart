import 'package:flutter/material.dart';
import 'package:flutter_application_2/edit.dart';
import '../models/db.dart';
import '../services/db_helper.dart';
import 'login.dart';
import 'edit.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'inputimg.dart';
import 'button.dart';
import 'location.dart';
import 'login_or_register_page.dart';
import 'auth_service.dart';

Future<String> getUsername() async {
  final lst = await DatabaseHelper.getData();
  return lst[0];
}

Future<String> getEmail() async {
  final lst = await DatabaseHelper.getData();
  if (lst[5] == "0") {
    return "-";
  } else {
    return lst[5];
  }
}

Future<String> getPasswordEdit() async {
  final lst = await DatabaseHelper.getData();
  return lst[1];
}

Future<String> getPassword() async {
  final lst = await DatabaseHelper.getData();
  String str = "";
  for (int i = 0; i < lst[1].length; i++) {
    var char = lst[1][i];
    if (i == 0 || i == lst[1].length - 1) {
      str += char;
    } else {
      str += "*";
    }
  }
  // return lst[1][0];
  return str;
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

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String? imagePath;

  void _updateImage(String? path) {
    setState(() {
      imagePath = path;
    });
  }

  Future<void> _openAnotherPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InputImg()),
    );
    if (result != null && result is String) {
      _updateImage(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pink.shade300,
        actions: [
          TextButton.icon(
            onPressed: () async {
              var x=await getEmail();
              if(x!="-")
                {

                  AuthService().signOut();
                }
              await DatabaseHelper.unCurr();
              await Future.delayed(const Duration(seconds: 1));
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
                );
              }
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            label: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/564x/6f/1c/7a/6f1c7aafd8cb396dc06afa54d75c3e7c.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 1200,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 10,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    'My Account',
                                    style: TextStyle(
                                      fontFamily: 'Tlwg Typewriter',
                                      fontSize: 34,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.account_circle,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  'https://www.pngitem.com/pimgs/m/404-4042686_my-profile-person-icon-png-free-transparent-png.png',
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(minHeight: 250),
                                child: Table(
                                  children: [
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: FutureBuilder<String>(
                                            future: getUsername(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                return Text(
                                                  snapshot.data!,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: FutureBuilder<String>(
                                            future: getPassword(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                return Text(
                                                  snapshot.data!,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: FutureBuilder<String>(
                                            future: getEmail(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<String>
                                                snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                return Text(
                                                  snapshot.data!,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            'Username',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            'Password',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            'Email',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 25.0),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 24,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Emergency Contacts',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: 1800,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: FutureBuilder<String>(
                              future: getContact1(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(width: 10),
                                      Text(
                                        'Contact 1: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 50),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                    'Error fetching contact information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  );
                                } else {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 24,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Contact 1: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 50),
                                      Text(
                                        snapshot.data!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),

                            /*child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 24,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Contact 1: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 50),
                                Text(
                                  '1111111',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),*/
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: 1800,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(10.0),
                            child: FutureBuilder<String>(
                              future: getContact2(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircularProgressIndicator(),
                                      SizedBox(width: 10),
                                      Text(
                                        'Contact 2: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 50),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                    'Error fetching contact information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  );
                                } else {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 24,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Contact 2: ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 50),
                                      Text(
                                        snapshot.data!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            /*child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 24,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Contact 2: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 50),
                                Text(
                                  '2222222',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),*/
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Material(
                            elevation: 5,
                            shadowColor: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 1800,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: FutureBuilder<String>(
                                future: getContact3(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(width: 10),
                                        Text(
                                          'Contact 3: ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                      ],
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text(
                                      'Error fetching contact information',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          size: 24,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Contact 3: ',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 50),
                                        Text(
                                          snapshot.data!,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Container(
                  width: 200,
                  height: 40,
                  child: FutureBuilder<String>(
                    future: getPasswordEdit(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Builder(
                          builder: (context) => ElevatedButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  TextEditingController text =
                                      TextEditingController();
                                  return AlertDialog(
                                    title: Text('Edit Profile'),
                                    content: TextField(
                                      controller: text,
                                      decoration: InputDecoration(
                                          hintText: 'Enter password'),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        child: Text('Edit Profile'),
                                        onPressed: () {
                                          String enteredText = text.text;
                                          if (enteredText == snapshot.data!) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditPage()),
                                            );
                                          } else {
                                            showDialog(
                                              context: dialogContext,
                                              builder:
                                                  (BuildContext errorContext) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Incorrect Password'),
                                                  content: Text(
                                                      'Please enter the correct password to edit your profile'),
                                                  actions: [
                                                    ElevatedButton(
                                                      child: Text('OK'),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            errorContext);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                side: BorderSide(
                                  color: Colors.pink,
                                  width: 3.0,
                                ),
                              ),
                            ),
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  /* child: Builder(
                    builder: (context) => ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            TextEditingController text =
                                TextEditingController();
                            return AlertDialog(
                              title: Text('Edit Profile'),
                              content: TextField(
                                controller: text,
                                decoration:
                                    InputDecoration(hintText: 'Enter password'),
                              ),
                              actions: [
                                ElevatedButton(
                                  child: Text('Edit Profile'),
                                  onPressed: () {
                                    String entered_text = text.text;
                                    if (entered_text.toLowerCase() == 'apple') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditPage()),
                                      );
                                    } else {
                                      showDialog(
                                        context: dialogContext,
                                        builder: (BuildContext errorContext) {
                                          return AlertDialog(
                                            title: Text('Incorrect Password'),
                                            content: Text(
                                                'Please enter the correct password to edit your profile'),
                                            actions: [
                                              ElevatedButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.pop(errorContext);
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          side: BorderSide(
                            color: Colors.pink,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),*/
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink.shade500,
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
