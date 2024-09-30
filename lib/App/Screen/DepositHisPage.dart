import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  //TextEditingController _searchController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  SafeArea(
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
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        // Expanded(
                        //     flex:25,
                        //     child: Text("UserId")),
                        Expanded(
                            flex:25,
                            child: Text("Amount")),
                        Expanded(
                            flex:25,
                            child: Text("Stutas")),
                        Expanded(
                            flex:25,
                            child: Text("CreateTime")),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Expanded(                               //orderBy('created_at',descending:true).
                      child: StreamBuilder(
                        stream: _firestore.collection('DepositDetails').where('user',isEqualTo:user?.uid).snapshots(),
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
                                      flex:25,
                                      child: Text("${document['Amount']}")),
                                  Expanded(
                                      flex:25,
                                      child: Text("${document['Status']}")),
                                  Expanded(
                                      flex:25,
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
