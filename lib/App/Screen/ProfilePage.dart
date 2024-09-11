import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ratailapp/Widget/AppEevatedButton.dart';
import 'package:ratailapp/Widget/AppTextField.dart';
import 'package:ratailapp/Widget/ProfilePage.dart';

import '../../Widget/SnackBar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _whatsAppController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? imgUrl;
  final user = FirebaseAuth.instance.currentUser;
  XFile? nidFrontPart;
  XFile? nidBackPart;
  XFile? userPhoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserProfileWidget(),
                const SizedBox(height: 12),
                AppTextFieldWidget(
                  controller: _nameController,
                  hintText: 'Name',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              
                const SizedBox(height: 12),
                AppTextFieldWidget(
                  controller: _addressController,
                  hintText: 'Address',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                AppTextFieldWidget(
                  controller: _whatsAppController,
                  hintText: 'WhatsApp Number',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your WhatsApp number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                buildImagePicker(
                  'NID Front Photo',
                  nidFrontPart?.name ?? '',
                  nidFrontPartPicker,
                ),
                const SizedBox(height: 12),
                buildImagePicker(
                  'NID Back Photo',
                  nidBackPart?.name ?? '',
                  nidBackPartPicker,
                ),
                const SizedBox(height: 12),
                buildImagePicker(
                  'Selfie',
                  userPhoto?.name ?? '',
                  userPhotoPicker,
                ),
                const SizedBox(height: 12),
                Container(
                  height: 48,
                  width: 358,
                  child: _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : AppElevatedButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        uploadImageAndGetLink();
                      }
                    },
                    child: Center(
                      child: Text(
                        "Submit",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 14,
                          ),
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

  Widget buildImagePicker(
      String title, String fileName, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                )),
            child: Text(title),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  )),
              child: Text(
                fileName,
                maxLines: 1,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void nidFrontPartPicker() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick image from'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () async {
                  nidFrontPart =
                  await ImagePicker().pickImage(source: ImageSource.camera);
                  Navigator.of(context).pop();
                  if (nidFrontPart != null) {
                    setState(() {});
                  }
                },
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
              ),
              ListTile(
                onTap: () async {
                  nidFrontPart = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  Navigator.of(context).pop();
                  if (nidFrontPart != null) {
                    setState(() {});
                  }
                },
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  void nidBackPartPicker() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick image from'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () async {
                  nidBackPart =
                  await ImagePicker().pickImage(source: ImageSource.camera);
                  Navigator.of(context).pop();
                  if (nidBackPart != null) {
                    setState(() {});
                  }
                },
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
              ),
              ListTile(
                onTap: () async {
                  nidBackPart = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  Navigator.of(context).pop();
                  if (nidBackPart != null) {
                    setState(() {});
                  }
                },
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  void userPhotoPicker() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick image from'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () async {
                  userPhoto =
                  await ImagePicker().pickImage(source: ImageSource.camera);
                  Navigator.of(context).pop();
                  if (userPhoto != null) {
                    setState(() {});
                  }
                },
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
              ),
              ListTile(
                onTap: () async {
                  userPhoto = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  Navigator.of(context).pop();
                  if (userPhoto != null) {
                    setState(() {});
                  }
                },
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> uploadImageAndGetLink() async {
    if (nidFrontPart == null || nidBackPart == null || userPhoto == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final frontPartUrl = await uploadFile(nidFrontPart!);
      final backPartUrl = await uploadFile(nidBackPart!);
      final userPhotoUrl = await uploadFile(userPhoto!);

      await uploadDataToFirebase(frontPartUrl, backPartUrl, userPhotoUrl);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data uploaded successfully'))
      );

    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> uploadFile(XFile file) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().toString()}/${file.name}');
    await storageRef.putFile(File(file.path));
    return await storageRef.getDownloadURL();
  }

  Future<void> uploadDataToFirebase(
      String frontPartUrl, String backPartUrl, String userPhotoUrl) async {
    final user = FirebaseAuth.instance.currentUser;

    try {
     final Result= await FirebaseFirestore.instance.collection('Check').doc(user?.uid).set({
        'whats_app': _whatsAppController.text,
        'address': _addressController.text,
        'name': _nameController.text,
        //'uid': user!.uid,
        'nid_front': frontPartUrl,
        'nid_back': backPartUrl,
        'user_photo': userPhotoUrl,
      } ,SetOptions(merge: true));


    } catch (e) {
      print(e);
    }
  }
}