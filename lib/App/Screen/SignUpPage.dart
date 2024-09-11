import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ratailapp/Widget/AppTextField.dart';
import 'package:ratailapp/Widget/SnackBar.dart';

import 'package:ratailapp/App/Screen/LoginPage.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController emailETController = TextEditingController();
  final TextEditingController nameETController = TextEditingController();
  final TextEditingController mobileETController = TextEditingController();
  final TextEditingController passwordETController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _signUp(BuildContext context) async {
    try {
      // Check if the mobile number already exists
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Check')
          .where('mobile', isEqualTo: mobileETController.text)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        showSnackBarMessage(context, 'Mobile number already exists!', true);
        return;
      }

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailETController.text,
        password: passwordETController.text,
      )
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('Check')
            .doc(value.user!.uid)
            .set({
          'name': nameETController.text,
          'mobile': mobileETController.text,
          'email': emailETController.text,
          'user': value.user!.uid,
          'rate': 50,
          'diamond': 0,
          'type': 'user',
          'password': int.tryParse(passwordETController.text) ?? 0,
        });
        return value;
      });

      showSnackBarMessage(context, 'Registration successful!');
    } catch (e) {
      print('Error signing up: $e');
      showSnackBarMessage(context, 'Registration failed! Try again', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Get Registration'),
                  SizedBox(height: 20),
                  AppTextFieldWidget(
                    controller: emailETController,
                    hintText: 'Email',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  AppTextFieldWidget(
                    controller: nameETController,
                    hintText: 'Name',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  AppTextFieldWidget(
                    controller: mobileETController,
                    hintText: 'Mobile',
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your valid mobile';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  AppTextFieldWidget(
                    controller: passwordETController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if ((value?.isEmpty ?? true) ||
                          (value?.length ?? 0) < 6) {
                        return 'Enter password more than 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _signUp(context);
                      }
                    },
                    child: Text('Register'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInSreen()),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
