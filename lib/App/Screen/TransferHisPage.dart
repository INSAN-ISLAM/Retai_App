import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart';

class TransferScreen extends StatefulWidget {
  TransferScreen({Key? key}) : super(key: key);


  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool m = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // late Future<DocumentSnapshot> _documentFuture;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _documentFuture = _getDocument();
  // }
  //
  // Future<DocumentSnapshot> _getDocument() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     print(user!.uid);
  //     return await _firestore.collection('ReceiptDetails').doc("user?.uid").get();
  //   } catch (e) {
  //     throw Exception('Error fetching document: $e');
  //   }
  // }
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child:Container(
              height: 800,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("INDEX") ,
                    Row(
                      children: [
                        // Expanded(
                        //     flex:25,
                        //     child: Text("Id")),
                        Expanded(
                            flex:33,
                            child: Text("TransferNumber")),
                        Expanded(
                            flex:33,
                            child: Text("Daimond Amount")),
                        Expanded(
                            flex:33,
                            child: Text("CreateTime")),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Expanded(
                      child: StreamBuilder(
                        stream: _firestore.collection('TransferDetails')
                            .where('user',isEqualTo:user?.uid).orderBy('created_at', descending: true).snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData) {
                            return Center(child: Text('No data found'));
                          }

                          final documents = snapshot.data!.docs;
                          final data = documents.where((element) => element['user'] == user!.uid).toList();
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final document = data[index];
                              var date= document['created_at'].toDate();
                              var formattedDate = DateFormat.yMMMd().format(date);

                              return Row(
                                children: [
                                  // Expanded(
                                  //     flex:25,
                                  //     child: Text( "${document['UserId']}")),
                                  Expanded(
                                      flex:33,
                                      child: Text("${document['TransferNumber']}")),
                                  Expanded(
                                      flex:33,
                                      child: Text("${document['TransferDiamond']}")),
                                  Expanded(
                                      flex:33,
                                      child: Text(
                                        "$formattedDate",
                                        //   "CreateTime"
                                      )),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),

                  ],
                ),
              )


          ),
        ),

      ),

    );
  }
}
