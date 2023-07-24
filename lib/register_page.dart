import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import 'auth_service.dart';
import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'acc.dart';
import '../models/db.dart';
import '../services/db_helper.dart';
import '../services/location_helper.dart';
import 'inputimg.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  final Users? user;
  const RegisterPage({super.key, required this.onTap, this.user});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controller
  String? lat, long, country, adminArea;
  List<TextEditingController> contactControllers = [];
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();
  final usernameCtrlr = TextEditingController();
  final passwordCtrlr = TextEditingController();
  final contact1Ctrlr = TextEditingController();
  final contact2Ctrlr = TextEditingController();
  final contact3Ctrlr = TextEditingController();
  // sign user up method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      if (passwordController.text == confirmedPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        //error message
        passwordsDoNotMatch();
      }
      // pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage();
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessage();
      }
    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Email',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void passwordsDoNotMatch() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Passwords Do Not Match!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

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
      backgroundColor: Color.fromARGB(255, 233, 167, 225),
      body: SafeArea(
          child: Stack(
          children: <Widget>[
           /* Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  //image: AssetImage("assets/images/flower.jpeg"),
                  image: NetworkImage(
                      'https://img.freepik.com/free-vector/watercolor-sugar-cotton-clouds-background_52683-80661.jpg?w=2000'),
                  fit: BoxFit.cover,
                ),
              ),
            ),*/
           SingleChildScrollView(
            
        child: Padding(
          padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.lock,
                  size: 50,
                ),

                const SizedBox(height: 50),

                // Create an account
                const Text(
                  'Create an account',
                  style: TextStyle(
                    color: Color.fromARGB(255, 17, 3, 3),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                TextField(
                  controller: usernameCtrlr,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Colors.grey[500])),
                  /*decoration: const InputDecoration(
                          labelText: 'Username',
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20.0),
                        ),*/
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                FancyPasswordField(
                  controller: passwordCtrlr,
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey[500])),
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

                const SizedBox(height: 10),

                //confirm password
                for (var i = 0; i < contactControllers.length; i++)
                  FancyPasswordField(
                      controller: contactControllers[i],
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Enter Contact',
                          hintStyle: TextStyle(color: Colors.grey[500])),
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
                      }),
                SizedBox(height: 16.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (contactControllers.length < 3) {
                          setState(() {
                            contactControllers.add(TextEditingController());
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
                const SizedBox(height: 10),

                // sign in button
                ElevatedButton(
                  onPressed: () async {
                    final username = usernameCtrlr.value.text;
                    final password = passwordCtrlr.value.text;
                    final contact1 = contactControllers[0].value.text;
                    String contact2 = "0", contact3 = "0";
                    if (contactControllers.length == 3) {
                      contact2 = contactControllers[1].value.text;
                      contact3 = contactControllers[2].value.text;
                    } else if (contactControllers.length == 2) {
                      contact2 = contactControllers[1].value.text;
                      contact3 = "0";
                    }
                    //final contact3 = contact3Ctrlr.value.text;

                    if (username.isEmpty ||
                        password.isEmpty ||
                        contact1.isEmpty) {
                      return;
                    }

                    if (widget.user == null) {
                      if (contact2 == "0" && contact3 != "0") {
                        final Users model = Users(
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
                      } else if (contact3 == "0" && contact2 != "0") {
                        final Users model = Users(
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
                      } else if (contact2 == "0" && contact3 == "0") {
                        final Users model = Users(
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
                      } else if (contact2 != "0" && contact3 != "0") {
                        final Users model = Users(
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
                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'assets/images/google.png'),

                    const SizedBox(width: 25),
                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
           ),
          ),
          ],
        ),
        // ],
        // ),
      ),
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
