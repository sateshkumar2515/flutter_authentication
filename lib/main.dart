import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fingerprint_app/secondActivity.dart';
import 'package:local_auth/local_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FingerPrint(),
    );
  }
}

class FingerPrint extends StatefulWidget {
  @override
  _FingerPrintState createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {
  @override
  void initState() {
    // TODO: implement initState
     _checkBiometric();
    getListBiometricType();
    //_authorize();

    super.initState();
  }

  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _canCheckBiometric = false;
  String _authorizeorNot = "Not Authorize";
  List<BiometricType> _availableBiometricTypes = List<BiometricType>();

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> getListBiometricType() async {
    List<BiometricType> ListOfBiometric;

    try {
      ListOfBiometric = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricTypes = ListOfBiometric;
    });
  }

  Future<void> _authorize() async {
    bool isauthorize = false;

    try {
      isauthorize = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Please authorized to secure your file",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isauthorize) {
        _authorizeorNot = "Authorized";
        Navigator.push(context, MaterialPageRoute(builder: (context) =>SecondActivity() ));


      } else {
        _authorizeorNot = " Not Authorized";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fingerprint check'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //  Expanded(child: Text('$_checkBiometric'),),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(child: Text('$_authorizeorNot',style: TextStyle(fontSize: 20.0,color: Colors.teal[300]),)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('$_availableBiometricTypes',style: TextStyle(fontSize: 20.0,color: Colors.teal[300]),),
            ),
          ),
          Container(


            child: Padding(

            padding: const EdgeInsets.all(15.0),
              child: FlatButton(

                color: Colors.teal[600],
                textColor: Colors.white,
                child: Text('Click Here for Checking Biometric'),
                onPressed: () {
                  _authorize();
                  
                  if(_authorizeorNot == "Authorized"){
                    

                  }else{
                    print('not autorized');
                  }
                  
                  
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
