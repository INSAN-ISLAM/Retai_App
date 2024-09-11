import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiptAcceptScreen extends StatefulWidget {
  const ReceiptAcceptScreen({Key? key}) : super(key: key);

  @override
  State<ReceiptAcceptScreen> createState() => _ReceiptAcceptScreenState();
}

class _ReceiptAcceptScreenState extends State<ReceiptAcceptScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<DocumentSnapshot> _documentFuture;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _documentFuture = _getDocument();
  }

  Future<DocumentSnapshot> _getDocument() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      print(user!.uid);
      return await _firestore
          .collection('ReceiptDetails')
          .doc("user?.uid")
          .get();
    } catch (e) {
      throw Exception('Error fetching document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Container(
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
                  Text("Receipt List"),
                  Row(
                    children: [
                      Expanded(flex: 30, child: Text("Receipt Number")),
                      Expanded(flex: 20, child: Text("Diamond")),
                      Expanded(flex: 25, child: Text("Status")),
                      Expanded(flex: 25, child: Text("CreateTime")),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream:
                          _firestore.collection('ReceiptDetails')
                              .where('user',isEqualTo:user?.uid)

                              .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData) {
                          return Center(child: Text('No data found'));
                        }

                        final documents = snapshot.data!.docs;

                        return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final document = documents[index];
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
                                    flex: 25,
                                    child: Text("${document['Status']}")),
                                Expanded(
                                    flex: 25,
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
            )),
      ),
    ));
  }
}






















//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ReceiptAcceptScreen extends StatefulWidget {
//   const ReceiptAcceptScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ReceiptAcceptScreen> createState() => _ReceiptAcceptScreenState();
// }
//
// class _ReceiptAcceptScreenState extends State<ReceiptAcceptScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   late Future<DocumentSnapshot> _documentFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _documentFuture = _getDocument();
//   }
//
//   Future<DocumentSnapshot> _getDocument() async {
//     try {
//       //  User? user = FirebaseAuth.instance.currentUser;
//       //print(user!.uid);
//       return await _firestore.collection('ReceiptDetails').doc("bmDWYb9magRUlvwDoCAD").get();
//     } catch (e) {
//       throw Exception('Error fetching document: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//           child: Padding(
//       padding: EdgeInsets.all(5.0),
//       child: FutureBuilder(
//             future: _documentFuture,
//             builder:
//                 (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               if (!snapshot.hasData || !snapshot.data!.exists) {
//                 return Center(child: Text('Document does not exist'));
//               }
//               Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//               return Container(
//                   height: 800,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(16),
//                       bottomRight: Radius.circular(16),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Receipt List"),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: [
//                               Container(
//                                   color: Colors.white,
//                                   // padding: EdgeInsets.all(20.0),
//                                   width: MediaQuery.of(context).size.width,
//                                   child: DataTable(
//                                     columnSpacing: .2,
//                                     columns: [
//                                       DataColumn(
//                                         label: Text('Receipt Id'),
//                                       ),
//                                       DataColumn(
//                                         label: Text('Amount'),
//                                       ),
//                                       DataColumn(
//                                         label: Text('Stutas'),
//                                       ),
//                                       DataColumn(
//                                         label: Text('CreateTime'),
//                                       ),
//
//                                       // DataColumn(
//                                       //   label: Text('Amount'),
//                                       // ),
//                                     ],
//                                     rows:  [
//                                       DataRow(cells: [
//                                         DataCell(Text("${data['ReceiptId']}")),
//                                         DataCell(Text("${data['TransferA']}")),
//                                         DataCell(Text(
//                                           'Pending',
//                                           style: TextStyle(color: Colors.green),
//                                         )),
//                                         DataCell(Text(
//                                           "${data['created_at'].toDate()}",
//                                           style: TextStyle(color: Colors.green),
//                                         )),
//                                         // DataCell(Text('Canccel',style: TextStyle(color: Colors.red),),onTap: (){},),
//                                         // DataCell(Text('265\$')),
//                                       ]),
//                                     ],
//                                   )),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ));
//             }),
//     ),
//         ));
//   }
// }
