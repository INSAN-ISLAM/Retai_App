import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ratailapp/App/Screen/CreateTransferPage.dart';
class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CreateTransferScreen(),

    );
  }
}
