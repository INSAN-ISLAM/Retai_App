import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:ratailapp/App/Screen/NavigationBar.dart';

import 'package:ratailapp/Widget/AppEevatedButton.dart';
import 'package:ratailapp/Widget/AppTextField.dart';


import 'ResetPassword.dart';

class LogInSreen extends StatefulWidget {
   LogInSreen({Key? key}) : super(key: key);

  @override
  State<LogInSreen> createState() => _LogInSreenState();
}

class _LogInSreenState extends State<LogInSreen> {
  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _passwordETController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool m = true;
  //get user => null;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailETController.text,
        password: _passwordETController.text,
      );
      // User logged in successfully
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainBottomNavBar()));
      print('User logged in: ${result.user!.uid}');
    } catch (e) {
      print('Error logging in: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text('Login to your account & start delivering.',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xFF6A7189),
                          fontSize: 16,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                AppTextFieldWidget(
                  controller: _emailETController,
                  hintText: 'Enter Your Email',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                AppTextFieldWidget(
                  obscureText: m,
                  hintText: 'Enter Your Password',
                  controller: _passwordETController,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    onPressed: () {
                      setState(() {
                        m = !m;
                      });
                    },
                  ),
                  validator: (value) {
                    if ((value?.isEmpty ?? true) &&
                        ((value?.length ?? 0) < 6)) {
                      return 'Enter password more than 6';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 48,
                  width: 358,
                  child: AppElevatedButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {

                        _login();
                      }
                    },
                    child: Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14,
                            //fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center( child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword()));
                  },
                  child:  Text('Forgot Password?',
                    style:GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Color(0xFFEF232F),
                        fontSize: 14,
                      ),
                    ),

                  ),
                ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
