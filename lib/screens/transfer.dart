import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_banking/helpers/dropdown_helper.dart';
import 'package:mobile_banking/screens/banking_action.dart';
import 'package:mobile_banking/widgets/bank_card.dart';

class Transfer extends StatefulWidget {
  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  DropdownHelper _dropdownHelper = DropdownHelper();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Color myBankBorderColor = notSelectedColor;
  Color othersBorderColor = notSelectedColor;

  bool isMyBank = false;
  bool isOthers = false;
  bool isDisplayForm = false;
  bool isDisplayAccountDetailForm = false;

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
              ? Container(
                  child: isMyBank == true
                      ? Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Account Number',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.account_circle),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 15),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Amount',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.money),
                              ),
                              keyboardType: TextInputType.number,
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
                              onTap: (startLoading, stopLoading, btnState) {},
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              hint: Text(
                                'Select Bank',
                                style: TextStyle(color: Colors.grey),
                              ),
                              items: _dropdownHelper.getBankDropdownItems(),
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
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Account Number',
                                            border: OutlineInputBorder(),
                                            prefixIcon:
                                                Icon(Icons.account_circle),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                        SizedBox(height: 15),
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Amount',
                                            prefixIcon: Icon(Icons.money),
                                            border: OutlineInputBorder(),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                        SizedBox(height: 15),
                                        ArgonButton(
                                          width: 350,
                                          height: 40,
                                          child: Text(
                                            'Transfer',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.blue,
                                          onTap: (startLoading, stopLoading,
                                              btnState) {
                                            scaffoldKey.currentState
                                                .showBottomSheet(
                                              (context) => Container(
                                                height: 230,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                )
              : Container(),
        ],
      ),
    );
  }
}
