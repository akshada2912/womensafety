import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Fingerprint(),
));

class Fingerprint extends StatefulWidget{
  @override
  _FingerprintState createState() => _FingerprintState();
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class _FingerprintState extends State<Fingerprint> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
          ? _SupportState.supported
          : _SupportState.unsupported),
    );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Authenticate using Fingerprint',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
            () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.pinkAccent[50],
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    color: Colors.pinkAccent,
                    padding: EdgeInsets.all(10.0),
                    child: Text('EMERGENCY'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                          'assets/kindpng_6688103.png',
                          width: 100.0
                      ),
                      Text("                       "),
                      Text("Fingerprint Authentication",
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15.0),
                        width: 150.0,
                        child: Text("Message will be sent to emergency contact",
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(
                              color: Colors.pinkAccent,
                              fontSize: 15.0,
                            )
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 15.0),
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed:_authenticate ,
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.pink[100],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular((30.0)),
                                  )
                              ),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14.0,
                                      horizontal: 24.0),
                                  child: Text("Authenticate",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 15.0,
                                          height: 1.5
                                      )
                                  )
                              )
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
