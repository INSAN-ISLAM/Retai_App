//
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ratailapp/Widget/AppEevatedButton.dart';
// import 'package:ratailapp/Widget/AppTextField.dart';
//
//
// import '../../Widget/GetUpDateNumPage.dart';
// import 'DepositHisPage.dart';
//
// class DepositScreen extends StatefulWidget {
//   const DepositScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<DepositScreen> createState() => _DepositScreenState();
// }
//
// class _DepositScreenState extends State<DepositScreen> {
//   // XFile? pickedImage;
//   // String? base64Image;
//
// // uncomplete action
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             Text(
//               'PayMent',
//               style: GoogleFonts.poppins(
//                 textStyle: const TextStyle(
//                   color: Colors.black,
//
//                   fontSize: 30,
//
//                   //fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             SizedBox(height: 50),
//             Center(
//               child: OutlinedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               PayMentPage()));
//
//                 },
//                 child: SvgPicture.asset(
//                   'assets/images/BKashLogo.svg',
//                   height: 100,
//                   width: 108,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: OutlinedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) =>
//                               PayMentPage()));
//
//
//                 },
//                 child: SvgPicture.asset(
//                   'assets/images/NagadLogo.svg',
//                   height: 120,
//                   width: 200,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class PayMentPage extends StatefulWidget {
//   //final String image;
//
//   const PayMentPage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<PayMentPage> createState() => _PayMentPageState();
// }
//
// class _PayMentPageState extends State<PayMentPage> {
//   final TextEditingController _nameETController = TextEditingController();
//   final TextEditingController _AmountETController = TextEditingController();
//   final TextEditingController _TrxIDETController = TextEditingController();
//   final TextEditingController _DiamondRETController = TextEditingController();
//   final TextEditingController _PhNumETController = TextEditingController();
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool m = true;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   String? _selectedGateway;
//   final List<String> _gateways = ['Bkash', 'Nagad'];
//   final user = FirebaseAuth.instance.currentUser;
//   double? userRate;
//   int? userNumber;
//   XFile? userPhoto;
//   bool _isLoading = false;
//   @override
//   void initState() {
//     super.initState();
//     _fetchData();
//     _fetchUserRate();
//   }
//
//   void _fetchData() async {
//     QuerySnapshot querySnapshot =
//     await _firestore.collection('DepositDetails').get();
//     setState(() {
//       m = false;
//     });
//   }
//
//   void _fetchUserRate() async {
//     DocumentSnapshot documentSnapshot =
//     await _firestore.collection('Check').doc(user!.uid).get();
//
//     if (documentSnapshot.exists) {
//       setState(() {
//         userRate = documentSnapshot.get('rate');
//         userNumber = documentSnapshot.get('mobile');
//
//         //print(userRate);
//       });
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 12),
//                 UserProfileWidget(),
//
//                 const SizedBox(height: 12),
//                 Text('Payment Information',
//                     style: GoogleFonts.poppins(
//                       textStyle: const TextStyle(
//                         color: Color(0xFF6A7189),
//                         fontSize: 16,
//                       ),
//                     )),
//                 const SizedBox(height: 12),
//                 DropdownButtonFormField<String>(
//                   value: _selectedGateway,
//                   hint: Text('Select Payment Gateway'),
//                   items: _gateways.map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedGateway = newValue;
//                     });
//                   },
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Please select a payment gateway';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 AppTextFieldWidget(
//                   controller: _TrxIDETController,
//                   hintText: 'TrxID',
//                   validator: (value) {
//                     if (value?.isEmpty ?? true) {
//                       return 'Wrong Number';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 AppTextFieldWidget(
//                   controller: _PhNumETController,
//                   hintText: 'PhNum',
//                   validator: (value) {
//                     if (value?.isEmpty ?? true) {
//                       return 'Wrong Number';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 12),
//
//                 AppTextFieldWidget(
//                   controller: _AmountETController,
//                   hintText: 'Amount',
//                   suffixIcon: Text('Taka'),
//                   validator: (value) {
//                     if (value?.isEmpty ?? true) {
//                       return 'Wrong Number';
//                     }
//                     return null;
//                   },
//                   onChanged: (value) {
//                     if (userRate != null && userRate != 0) {
//                       setState(() {
//                         print('value: $value, userRate: $userRate');
//                         if (value != null) {
//                           final amount = int.tryParse(value) ?? 0;
//                           final rateInt = userRate!; // Convert userRate to integer
//                           _DiamondRETController.text = ((amount ~/ 100) * rateInt ).toString();// Use integer division
//                           print('daimond:-${_DiamondRETController.text} ');
//                         } else {
//                           // Handle the case where value is null
//                           _DiamondRETController.text = '0';
//                         }
//                       });
//                     } else {
//                       setState(() {
//                         _DiamondRETController.text = '0';
//                       });
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 AppTextFieldWidget(
//                   controller: _DiamondRETController,
//                   hintText: 'Diamond',
//                   readOnly:
//                   true, // Set the text field to read-only instead of using enabled
//                 ),
//
//                 const SizedBox(height: 12),
//                 buildImagePicker(
//                   'screen_short',
//                   userPhoto?.name ?? '',
//                   userPhotoPicker,
//
//                 ),
//                 const SizedBox(height: 12),
//                 Container(
//                   height: 48,
//                   width: 358,
//                   child:_isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       :  AppElevatedButton(
//                     onTap: () {
//
//                       if (_formKey.currentState!.validate()) {
//
//                         _uploadImageAndGetLink();
//                       }
//
//                     },
//                     child: Center(
//                       child: Text(
//                         "Deposit Now",
//                         style: GoogleFonts.poppins(
//                           textStyle: const TextStyle(
//                             color: Color(0xFFFFFFFF),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget buildImagePicker(
//       String title, String fileName, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: const BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   bottomLeft: Radius.circular(8),
//                 )),
//             child: Text(title),
//           ),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(8),
//                     bottomRight: Radius.circular(8),
//                   )),
//               child: Text(
//                 fileName,
//                 maxLines: 1,
//                 style: const TextStyle(overflow: TextOverflow.ellipsis),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void userPhotoPicker() async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Pick image from'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 onTap: () async {
//                   userPhoto = await ImagePicker().pickImage(source: ImageSource.gallery);
//                   Navigator.of(context).pop();
//                   if (userPhoto != null) {
//                     setState(() {
//                       print(userPhoto);
//                     });
//
//                   }
//                 },
//                 leading: const Icon(Icons.image),
//                 title: const Text('Gallery'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//
//   Future<void> _uploadImageAndGetLink() async {
//     if (userPhoto == null) {
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final userPhotoUrl = await uploadFile(userPhoto!);
//       //print(' url:${userPhotoUrl}');
//       //await updateProfile(userPhotoUrl);
//
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Data uploaded successfully'))
//       );
//
//     } catch (e) {
//       print(e);
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//
//   Future<String> uploadFile(XFile file) async {
//     final storageRef = FirebaseStorage.instance
//         .ref()
//         .child('picture/${DateTime.now().toString()}/${file.name}');
//     //print(storageRef);
//     await storageRef.putFile(File(file.path));
//     return await storageRef.getDownloadURL();
//   }
//
//   Future<void> updateProfile() async {
//     // if (userPhotoUrl ! == null) {
//     //   print(userPhotoUrl);
//     // }
//     final user = FirebaseAuth.instance.currentUser;
//
//     try {
//       await FirebaseFirestore.instance.collection('DepositDetails').add({
//         'Amount': int.tryParse(_AmountETController.text) ?? 0,
//         'TrxID': _TrxIDETController.text,
//         'User Diamond': _DiamondRETController.text,
//         'Payment Gateway': _selectedGateway,
//         'PhNum': _PhNumETController.text,
//         'Status': 'unpaid',
//         'created_at': FieldValue.serverTimestamp(),
//         'user': user!.uid,
//         'mobile': userNumber,
//         //'user_photo': userPhotoUrl,
//       }).then((_) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//                 'Deposit Request Send To Admin successfully, Please Wait For Accept ')));
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => OrderScreen()),
//         );
//       }).catchError((error) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Failed to update data')));
//       });
//     } catch (e) {
//       print('Error signing up: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Registration Failed! Try again')));
//     }
//   }
// }
