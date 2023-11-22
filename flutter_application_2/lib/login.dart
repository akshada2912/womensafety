import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import '../models/db.dart';
import '../services/db_helper.dart';
import 'acc.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_2/components/my_button.dart';
import 'package:flutter_application_2/components/my_textfield.dart';
import 'package:flutter_application_2/components/square_tile.dart';
import 'auth_service.dart';

void sendEmail() async {
  final smtpServer = SmtpServer('smtp.gmail.com',
      username: 'kakpie3@gmail.com', // your email id
      password: 'kakshu29', // your password
      port: 587);
  final message = Message()
    ..from = Address('bhavani.chalasani99@gmail.com', 'b') // email id of sender
    ..recipients.add('bhavani.chalasani99@gmail.com') // email id of reciever
    ..subject = 'Automated Email'
    ..text = 'This is an automated email sent from Flutter!';

  try {
    final sendReport = await send(message, smtpServer);
    print('Email sent successfully! Message ID: ${sendReport.toString()}');
  } catch (e) {
    print('Error sending email: $e');
  }
}

class LoginPage extends StatefulWidget {
  final Users? user;
  final Function()? onTap;
  const LoginPage({Key? key, this.user, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameCtrlr = TextEditingController();
  final TextEditingController passwordCtrlr = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final smtpServer = SmtpServer('smtp.gmail.com',
      username: 'kakpie3@gmail.com', // your email id
      password: 'kakshu29', // your password
      port: 587);

  void signUserIn() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // pop the loading circle
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

  @override
  Widget build(BuildContext context) {
    double stripWidth = 0.1 * MediaQuery.of(context).size.width;
    double containerHeight = 600.0;
    if (widget.user != null) {
      usernameCtrlr.text = widget.user!.username;
      passwordCtrlr.text = widget.user!.password;
    }
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SingleChildScrollView(
    child:Padding(
      padding: EdgeInsets.all(50.0),
       // child:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://i.pinimg.com/564x/fa/c0/cf/fac0cf5ce8ae42697dc794d5f2409d6c.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height:MediaQuery.of(context).size.height * 0.7, 
                child: Row(
                  children: [
                    Container(
                      width: stripWidth,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.pink.shade200, Colors.pink.shade500],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: containerHeight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16.0),
                            bottomRight: Radius.circular(16.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Icon(
                                  Icons.lock_outline,
                                  color: Colors.pink.shade200,
                                  size: 120.0,
                                ),
                                SizedBox(height: 50.0),
                                Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.pink.shade200,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  controller: usernameCtrlr,
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.grey),
                                  ),
                                  onEditingComplete: () {
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                                SizedBox(height: 50.0),
                                FancyPasswordField(
                                  controller: passwordCtrlr,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.grey),
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
                                  onEditingComplete: () async {
                                    final username = usernameCtrlr.value.text;
                                    final password = passwordCtrlr.value.text;

                                    if (username.isEmpty || password.isEmpty) {
                                      return;
                                    }
                                    int x = 0;
                                    if (widget.user == null) {
                                      final lst = List<String>.filled(2, "0");
                                      lst[0] = username;
                                      lst[1] = password;
                                      x = await DatabaseHelper.login(lst);
                                    }
                                    if (x != 0) {
                                      await Future.delayed(
                                          const Duration(seconds: 1));
                                      if (context.mounted) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AccountPage()));
                                      }
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext dialogContext) {
                                          return AlertDialog(
                                            title: Text('Login Failed'),
                                            content: Text(
                                                'Invalid username or password.'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(dialogContext);
                                                },
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                                SizedBox(height: 50.0),
                                FractionallySizedBox(
                                  widthFactor: 0.3,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 8.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.pink.shade200,
                                            Colors.pink.shade500
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          minWidth: 88.0,
                                          minHeight: 36.0,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Log In',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      final username = usernameCtrlr.value.text;
                                      final password = passwordCtrlr.value.text;

                                      if (username.isEmpty ||
                                          password.isEmpty) {
                                        //return;
                                      }
                                      int x = 0;
                                      if (widget.user == null) {
                                        final lst = List<String>.filled(2, "0");
                                        lst[0] = username;
                                        lst[1] = password;
                                        x = await DatabaseHelper.login(lst);
                                      }
                                      if (x != 0) {
                                        await Future.delayed(
                                            const Duration(seconds: 1));
                                        if (context.mounted) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AccountPage()));
                                        }
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext dialogContext) {
                                            return AlertDialog(
                                              title: Text('Login Failed'),
                                              content: Text(
                                                  'Invalid username or password.'),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        dialogContext);
                                                  },
                                                  child: Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 50.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment:Alignment.bottomCenter,
              child:Padding(
                padding:EdgeInsets.all(16.0),
            child:Column(
              children: [
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
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                        onTap: ()async {
                          AuthService().signInWithGoogle();
                          final lst2=List<String>.filled(1,"0");
                          final user = FirebaseAuth.instance.currentUser!;
                          lst2[0]=user.email!;
                          var x2=user.email!;
                          log('user: $x2');
                          await DatabaseHelper.logIn(lst2);
                          log('^^^^^^^^^^^^^^^^^^^^^^^^^');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AccountPage()));
                          //log('user: $x2');
                         // await DatabaseHelper.logIn(lst2);
                        },
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
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
      ),
          ],
        ),
        ),
     // ),
      ),
    );
  }
}
