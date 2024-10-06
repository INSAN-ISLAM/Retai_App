import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReachargeDetails extends StatefulWidget {
  const ReachargeDetails({Key? key}) : super(key: key);

  @override
  State<ReachargeDetails> createState() => _ReachargeDetailsState();
}

class _ReachargeDetailsState extends State<ReachargeDetails> {


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;



  final CollectionReference _itemsCollection = FirebaseFirestore.instance.collection('ReceiptDetails');

  void _showDeleteConfirmationDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteItem(id);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(String id) {
    _itemsCollection.doc(id).delete().then((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item deleted')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete item: $error')));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                        Expanded(flex: 30, child: Text("Receipt Num")),
                        Expanded(flex: 20, child: Text("Diamond")),
                        Expanded(flex: 20, child: Text("Status")),
                        Expanded(flex: 15, child: Text("Time")),
                        Expanded(flex: 15, child: Text("Action")),
                      ],
                    ),
                    SizedBox(height: 6,),
                    Expanded(                               //orderBy('created_at',descending:true).
                      child: StreamBuilder(
                        stream: _firestore.collection('ReceiptDetails').where('Status', isEqualTo: 'Pending').snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          //print(user!.uid);
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (!snapshot.hasData) {
                            return Center(child: Text('No data found'));
                          }
              //.where('Status', isEqualTo: 'Pending')
                          final documents = snapshot.data!.docs;

                          final data = documents.where((element) => element['user'] == user!.uid).toList();

                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final document = data[index];
                              var date = document['created_at'].toDate();
                              var formattedDate = DateFormat.yMMMd().format(date);

                              return Row(
                                children: [
                                  Expanded(
                                      flex: 30,
                                      child:
                                      Text("${document['ReceiptNumber']}")),
                                  Expanded(
                                      flex: 20,
                                      child:
                                      Text("${document['TransferDiamond']}")),
                                  Expanded(
                                      flex: 20,
                                      child: Text("${document['Status']}",style: TextStyle(
                                       color: Colors.pink
                                      ),)),
                                  Expanded(
                                      flex: 15,
                                      child: Text(
                                        "$formattedDate",
                                        //   "CreateTime"
                                      )),
                                  Expanded(
                                      flex: 15,
                                      child: TextButton(
                                        //onPressed: () => _deleteDocument(document.id),
                                          onPressed: () {

                                            _showDeleteConfirmationDialog(document.id);
                                          },
                                          child: Icon(Icons.delete,size: 20,))),
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
