import 'package:flutter/material.dart';
import 'package:mobile_banking/screens/recharge.dart';
import 'package:mobile_banking/screens/transfer.dart';

Color selectedColor = Colors.blue;
Color notSelectedColor = Colors.grey[300];

class BankingAction extends StatefulWidget {
  BankingAction({this.headerTitle});
  final String headerTitle;

  @override
  _BankingActionState createState() => _BankingActionState();
}

class _BankingActionState extends State<BankingAction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.headerTitle}',
        ),
      ),
      body: SingleChildScrollView(
        child: widget.headerTitle == 'Transfer' ? Transfer() : Recharge(),
      ),
    );
  }
}
