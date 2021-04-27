import 'package:flutter/material.dart';

class DropdownHelper {
  String selectedBank = '';
  String selectedISP = '';

  List<String> banks = [
    'UBA Bank',
    'Zenith Bank',
    'FCMB Bank',
    'GT Bank',
    'Access Bank'
  ];

  List<String> isps = ['MTN', 'Airtel', 'Glo', '9moblie'];

  List<DropdownMenuItem> getBankDropdownItems() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String bank in banks) {
      var newItem = DropdownMenuItem(child: Text(bank), value: bank);
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }

  List<DropdownMenuItem> getISPDropdownItems() {
    List<DropdownMenuItem<String>> dropdowmItems = [];

    for (String isp in isps) {
      var newItem = DropdownMenuItem(child: Text(isp), value: isp);
      dropdowmItems.add(newItem);
    }
    return dropdowmItems;
  }
}
