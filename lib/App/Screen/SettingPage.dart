import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratailapp/App/Screen/ChangePasswordPage.dart';
import 'package:ratailapp/App/Screen/LogInPage.dart';
import 'package:ratailapp/Widget/AppEevatedButton.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  MySnackBar(message, context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }


  void _showDeleteConfirmationDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are You sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                _signOut();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [

          ListTile(
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text("Change Password"),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword()), (route) => true);
              }),

          ListTile(
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text("Privacy "
                  "policy"),
              onTap: () {
                MySnackBar("I am phone", context);
              }),

          ListTile(
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              title: Text("Log Out"),
              onTap: () {
                _showDeleteConfirmationDialog();
              }),
        ],
      ),
    );
  }



  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut() async {
    await _auth.signOut();
    // Optionally, you can navigate to the login screen or show a message
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LogInSreen()));
  }
}



