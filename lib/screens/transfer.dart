import 'dart:async';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_banking/helpers/dropdown_helper.dart';
import 'package:mobile_banking/screens/banking_action.dart';
import 'package:mobile_banking/widgets/bank_card.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Transfer extends StatefulWidget {
  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  DropdownHelper _dropdownHelper = DropdownHelper();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Color myBankBorderColor = notSelectedColor;
  Color othersBorderColor = notSelectedColor;

  bool isMyBank = false;
  bool isOthers = false;
  bool isDisplayForm = false;
  bool isDisplayAccountDetailForm = false;
  String amount;

  //1 = my bank, 2 = others
  void updateBorderColor(int bankType) {
    //My bank

    if (bankType == 1) {
      if (myBankBorderColor == notSelectedColor) {
        myBankBorderColor = selectedColor;
        othersBorderColor = notSelectedColor;
      } else {
        myBankBorderColor = notSelectedColor;
      }
    }

    //othher banks
    if (bankType == 2) {
      if (othersBorderColor == notSelectedColor) {
        othersBorderColor = selectedColor;
        myBankBorderColor = notSelectedColor;
      } else {
        othersBorderColor = notSelectedColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: isDisplayForm == true
                      ? () {}
                      : () {
                          setState(() {
                            updateBorderColor(1);
                            isMyBank = true;
                          });
                        },
                  child: BankCard(
                    cardTitle: 'My Bank',
                    icon: Icons.account_balance,
                    borderColor: myBankBorderColor,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: InkWell(
                  onTap: isDisplayForm == true
                      ? () {}
                      : () {
                          setState(() {
                            updateBorderColor(2);
                            isOthers = true;
                          });
                        },
                  child: BankCard(
                    cardTitle: 'Others',
                    icon: Icons.more_horiz,
                    borderColor: othersBorderColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isDisplayForm == true
                  ? Container()
                  : ArgonButton(
                      width: 70,
                      height: 30,
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: myBankBorderColor == selectedColor ||
                              othersBorderColor == selectedColor
                          ? Colors.blue
                          : Colors.grey,
                      onTap: myBankBorderColor == selectedColor ||
                              othersBorderColor == selectedColor
                          ? (startLoading, stopLoading, btnState) {
                              print('Selected');
                              setState(() {
                                isDisplayForm = true;
                              });
                            }
                          : (startLoading, stopLoading, btnState) {
                              print('Not selectetd');
                            },
                    ),
            ],
          ),
          SizedBox(height: 20),
          isDisplayForm
              ? Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: isMyBank == true
                            ? Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Account Number is required';
                                      } else if (value.length < 10) {
                                        return 'Invalid Account Number';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Account Number',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.account_circle),
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                  ),
                                  SizedBox(height: 15),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Input amount';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Amount',
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.money),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      amount = value;
                                    },
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select a bank';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    hint: Text(
                                      'Select Bank',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    items:
                                        _dropdownHelper.getBankDropdownItems(),
                                    onChanged: (value) {
                                      setState(() {
                                        _dropdownHelper.selectedBank = value;
                                        isDisplayAccountDetailForm = true;
                                      });
                                    },
                                  ),
                                  isDisplayAccountDetailForm == true
                                      ? Container(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 15),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Account Number is required';
                                                  } else if (value.length <
                                                      10) {
                                                    return 'Invalid Account Number';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Account Number',
                                                  border: OutlineInputBorder(),
                                                  prefixIcon: Icon(
                                                      Icons.account_circle),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 10,
                                              ),
                                              SizedBox(height: 15),
                                              TextFormField(
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'Input amount';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Amount',
                                                  prefixIcon: Icon(Icons.money),
                                                  border: OutlineInputBorder(),
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) {
                                                  amount = value;
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                      ),
                      SizedBox(height: 15),
                      ArgonButton(
                        width: 350,
                        height: 40,
                        child: Text(
                          'Transfer',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onTap: (startLoading, stopLoading, btnState) async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            startLoading();
                            Timer(Duration(seconds: 2), () {
                              print('Loading');
                              Alert(
                                context: context,
                                type: AlertType.success,
                                // image: Image.file(user.image),
                                title: "SUCCESS",
                                desc: "N$amount has been transfered",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Continue",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {},
                                    width: 120,
                                  )
                                ],
                              ).show().then((value) {
                                stopLoading();
                              });
                            });
                          }
                        },
                        loader: Container(
                          padding: EdgeInsets.all(10),
                          child: SpinKitRotatingCircle(
                            color: Colors.white,
                            // size: loaderWidth ,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
