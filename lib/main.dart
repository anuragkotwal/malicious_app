import 'package:flutter/material.dart';
import 'package:android_intent/android_intent.dart';
import 'package:device_apps/device_apps.dart';

void main() {
  runApp(MyApp());
}
  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Malicious App"),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text(
              "Attack on app",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () async {
              bool isInstalled = await DeviceApps.isAppInstalled('com.example.loginapp');
              if (isInstalled == true)
                _openApp();
              else
                showAlertDialog(context);
              //_openLinkInGoogleChrome();
            },
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    content:
        Text("Unable to open app or the benign app is not install on your device"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void _openApp() {
  final AndroidIntent intent = AndroidIntent(
    action: 'action_view',
    data: Uri.decodeComponent('http://loginapp.com/'),
    package: 'com.example.loginapp',
    arguments: {'route': '/second'},
  );
  intent.launch();
}
