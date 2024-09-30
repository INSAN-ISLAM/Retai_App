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
      return await _firestore.collection('UpdatePhNum').doc('K8XGn7wA2MvP25EGCe2f').get();
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SelectableText("Bkash Number:-${data['BkashNum']}",),
                SizedBox(height: 4,),
                SelectableText("Nagad Number:-${data['NagadNum']}"),
          //Text(' Bkash Number:-${data['BkashNum']}'),
         // SizedBox(height: 4,),
          //Text('Nagad Number:-${data['NagadNum']}',),


          ]

          );
        }
    );
  }
}
