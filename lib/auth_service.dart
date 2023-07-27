import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_or_register_page.dart';
import 'button.dart';
import 'reg.dart';
import '../models/db.dart';
import '../services/db_helper.dart';

import 'dart:developer';

Future<int> emailExists() async {
  final user = FirebaseAuth.instance.currentUser!;
  log('user:$user');
  final lst = List<String>.filled(1, "0");
  lst[0] = user.email!;
  final x = await DatabaseHelper.isEmail(lst);
  print("**************************");
  print(x);
  print("**************************");
  final lst2=List<int>.filled(1,0);
  lst2[0]=x;
  return x;
}


class AuthService {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return
              //AuthService().signOut();
             FutureBuilder<int>(
              future: emailExists(),
                builder: (BuildContext context,
                    AsyncSnapshot<int> snapshot) {
                  if(snapshot.hasData) {
                    var s2=snapshot.data;
                    log('s2:$s2');
                    if (s2==0){
                      return HomeScreen();
                    }
                    else {
                      log('me');
                      return ButtonPage();
                    }
                  }
                  else{
                    return Container(child: Text('Loading'));
                  }
                }
            );
          } else {
            return const LoginOrRegisterPage();
          }
        });
  }

//called from the UI button
  signInWithGoogle() async {

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    //HomeScreen();
    await FirebaseAuth.instance.signInWithCredential(credential);
    final user = FirebaseAuth.instance.currentUser!;
    final lst=List<String>.filled(1,"0");
    lst[0]=user.email!;
    var x=user.email!;
    log('user: $x');
    await DatabaseHelper.logIn(lst);
    log('hi4');
    return await AuthService().handleAuthState();
    return;

  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }
}
