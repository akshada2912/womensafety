import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'acc.dart';
import '../models/db.dart';
import '../services/db_helper.dart';
import '../services/location_helper.dart';
import 'inputimg.dart';

class HomeScreen extends StatefulWidget {
  final User? user;
  const HomeScreen({Key? key, this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? lat, long, country, adminArea;
  List<TextEditingController> contactControllers = [];
  final _formKey = GlobalKey<FormState>();
  final usernameCtrlr = TextEditingController();
  final passwordCtrlr = TextEditingController();
  final contact1Ctrlr = TextEditingController();
  final contact2Ctrlr = TextEditingController();
  final contact3Ctrlr = TextEditingController();

  @override
  void initState() {
    super.initState();
    getLocation();
    contactControllers.add(TextEditingController());
  }

  @override
  Widget build(BuildContext context) {

    if (widget.user != null) {
      usernameCtrlr.text = widget.user!.username;
      passwordCtrlr.text = widget.user!.password;
      contact1Ctrlr.text = widget.user!.contact1;
    }
    return Scaffold(

      backgroundColor: const Color.fromARGB(255, 248, 213, 246),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 229, 12, 120),
        backgroundColor: Colors.pink[200],
        title: const Text('Sheguard'),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  //image: AssetImage("assets/images/flower.jpeg"),
                  image: NetworkImage(
                      'https://img.freepik.com/free-vector/watercolor-sugar-cotton-clouds-background_52683-80661.jpg?w=2000'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                //color: const Color.fromARGB(255, 248, 213, 246),
                padding: const EdgeInsets.all(55.0),
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: usernameCtrlr,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      /*const TextField(

              decoration: InputDecoration(
                labelText: 'Password',
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20.0),

              ),
              obscureText: true,
           ),*/
                      FancyPasswordField(
                        controller: passwordCtrlr,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20.0),
                        ),
                        validationRules: {
                          DigitValidationRule(),
                          UppercaseValidationRule(),
                          LowercaseValidationRule(),
                          SpecialCharacterValidationRule(),
                          MinCharactersValidationRule(6),
                          MaxCharactersValidationRule(12),
                        },
                        strengthIndicatorBuilder: (strength) => Text(
                          strength.toString(),
                        ),
                        validationRuleBuilder: (rules, value) {
                          if (value.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return ListView(
                            shrinkWrap: true,
                            children: rules
                                .map(
                                  (rule) => rule.validate(value)
                                  ? Row(
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    rule.name,
                                    style: const TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              )
                                  : Row(
                                children: [
                                  const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    rule.name,
                                    style: const TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            )
                                .toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 16.0),
                      /* FancyPasswordField(
                          controller: contact1Ctrlr,
                          decoration: const InputDecoration(
                            labelText: 'First Contact',
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 20.0),
                          ),
                          validationRules: {
                            DigitValidationRule(),
                            MinCharactersValidationRule(10),
                            MaxCharactersValidationRule(10),
                          },
                          strengthIndicatorBuilder: (strength) => Text(
                                strength.toString(),
                              ),
                          validationRuleBuilder: (rules, value) {
                            if (value.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            return ListView(
                              shrinkWrap: true,
                              children: rules
                                  .map(
                                    (rule) => rule.validate(value)
                                        ? Row(
                                            children: [
                                              const Icon(
                                                Icons.check,
                                                color: Colors.green,
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                rule.name,
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                rule.name,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                  )
                                  .toList(),
                            );
                          }
                          // obscureText: true,
                          ),
                      const SizedBox(height: 16.0),*/
                      for (var i = 0; i < contactControllers.length; i++)
                        FancyPasswordField(
                            controller: contactControllers[i],
                            decoration: InputDecoration(
                              labelText: 'Contact ${i + 1}',
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 20.0),
                            ),
                            validationRules: {
                              DigitValidationRule(),
                              MinCharactersValidationRule(10),
                              MaxCharactersValidationRule(10),
                            },
                            strengthIndicatorBuilder: (strength) => Text(
                              strength.toString(),
                            ),
                            validationRuleBuilder: (rules, value) {
                              if (value.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return ListView(
                                shrinkWrap: true,
                                children: rules
                                    .map(
                                      (rule) => rule.validate(value)
                                      ? Row(
                                    children: [
                                      const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        rule.name,
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  )
                                      : Row(
                                    children: [
                                      const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        rule.name,
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    .toList(),
                              );
                            }
                        ),
                      SizedBox(height: 16.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (contactControllers.length < 3) {
                                setState(() {
                                  contactControllers
                                      .add(TextEditingController());
                                });
                              }
                            },
                            child: Text('Add Contact'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (contactControllers.length > 1) {
                                setState(() {
                                  contactControllers.removeLast();
                                });
                              }
                            },
                            child: Text('Remove Contact'),
                          ),
                        ],
                      ),
                      /*ElevatedButton(
                            onPressed: () {
                              for (var i = 0;
                                  i < contactControllers.length;
                                  i++) {
                                String contact = contactControllers[i].text;
                                print('Contact ${i + 1}: $contact');
                              }
                            },
                            child: Text('Submit'),
                          ),*/
                      /*TextField(
                        controller: contact2Ctrlr,
                        decoration: const InputDecoration(
                          labelText: 'Second Contact',
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20.0),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextField(
                        controller: contact3Ctrlr,
                        decoration: const InputDecoration(
                          labelText: 'Third Contact',
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                          ),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20.0),
                        ),
                        //OutlineInputBorder: const BorderSide(color: Colors.grey, width: 0.0),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16.0),
                      */
                      ElevatedButton(
                        onPressed: () async {
                          final username = usernameCtrlr.value.text;
                          final password = passwordCtrlr.value.text;
                          final contact1 = contactControllers[0].value.text;
                          String contact2="0",contact3="0";
                          if(contactControllers.length==3)
                          {
                            contact2 =contactControllers[1].value.text;
                            contact3=contactControllers[2].value.text;
                          }
                          else if (contactControllers.length==2)
                          {
                            contact2 =contactControllers[1].value.text;
                            contact3="0";
                          }
                          //final contact3 = contact3Ctrlr.value.text;

                          if (username.isEmpty ||
                              password.isEmpty ||
                              contact1.isEmpty) {
                            return;
                          }

                          if (widget.user == null) {
                            if (contact2=="0" && contact3!="0") {
                              final User model = User(
                                  username: username,
                                  password: password,
                                  contact1: contact1,
                                  contact2: "0",
                                  contact3: contact3,
                                  id: widget.user?.id,
                                  curruser: 1);
                              print("hi1");
                              await DatabaseHelper.unCurr();
                              await DatabaseHelper.addUser(model);
                            } else if (contact3=="0" &&
                                contact2!="0") {
                              final User model = User(
                                  username: username,
                                  password: password,
                                  contact1: contact1,
                                  contact2: contact2,
                                  contact3: "0",
                                  id: widget.user?.id,
                                  curruser: 1);
                              print("hi2");
                              await DatabaseHelper.unCurr();
                              await DatabaseHelper.addUser(model);
                            } else if (contact2=="0" && contact3=="0") {
                              final User model = User(
                                  username: username,
                                  password: password,
                                  contact1: contact1,
                                  contact2: "0",
                                  contact3: "0",
                                  id: widget.user?.id,
                                  curruser: 1);
                              print("hi3");
                              await DatabaseHelper.unCurr();
                              await DatabaseHelper.addUser(model);
                            } else if (contact2!="0" &&
                                contact3!="0") {
                              final User model = User(
                                  username: username,
                                  password: password,
                                  contact1: contact1,
                                  contact2: contact2,
                                  contact3: contact3,
                                  id: widget.user?.id,
                                  curruser: 1);
                              print("hi4");
                              await DatabaseHelper.unCurr();
                              await DatabaseHelper.addUser(model);
                            }
                          }
                          await Future.delayed(const Duration(seconds: 1));
                          if (context.mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //builder: (context) => InputImg()));
                                    builder: (context) => AccountPage()));
                          }
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ).asGlass(),
              ),
            ),
          ],
        ),
      ),

      /*bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.white,
          backgroundColor: Colors.pink,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.pink,

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Account',
              backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.pink,
            ),
            ],
           ),*/
    );
  }

  void getLocation() async {
    final service = LocationService();
    final locationData = await service.getLocation();

    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);

      setState(() {
        /*lat = locationData.latitude!.toStringAsFixed(2);
        long = locationData.longitude!.toStringAsFixed(2);

        country = placeMark?.country ?? 'could not get country';
        adminArea = placeMark?.administrativeArea ?? 'could not get admin area';*/
      });
    }
  }
}
