import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class UserProfileWidget extends StatefulWidget {
   UserProfileWidget({ Key? key,}) : super(key: key);

  @override
  State<UserProfileWidget> createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late Future<DocumentSnapshot> _documentFuture;
var UserId;
  @override
  void initState() {
    super.initState();
    _documentFuture = _getDocument();
  }

  Future<DocumentSnapshot> _getDocument() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      UserId=user!.uid;
      print(user!.uid);
      return await _firestore.collection('Check').doc(user?.uid).get();
    } catch (e) {
      throw Exception('Error fetching document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _documentFuture,
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Document does not exist'));
          }
          Map<String, dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
          return ListTile(

            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const UpdateProfileScreen()));
            },
            contentPadding:  EdgeInsets.symmetric(
                horizontal: 16, vertical: 0),
            leading:  CircleAvatar(
              radius: 30,
                child:data['user_photo'] ==null? Icon(Icons.person,size: 40,): Image.network("${data['user_photo']}", fit: BoxFit.fill,)
//userData['user_photo'] ==null? Icon(Icons.person,size: 40,): Image.network(userData['user_photo']),


            ),



            tileColor: Colors.green,
            title: Text('${data['name']}'),
            subtitle: Text('UId:${UserId}'),
            // trailing: IconButton(
            //   onPressed: () async {
            //     // await AuthUtils.clearData();
            //     //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            //     //      builder: (context) => LoginScreen()), (route) => false);
            //   },
            //   icon: const Icon(Icons.logout, color: Colors.white,),
            // ),
          );
        }
    );
  }
}
