import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_banking/helpers/dropdown_helper.dart';
import 'package:mobile_banking/screens/banking_action.dart';
import 'package:mobile_banking/widgets/bank_card.dart';

class Recharge extends StatefulWidget {
  @override
  _RechargeState createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  DropdownHelper _dropdownHelper = DropdownHelper();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Color forSelfBorderColor = notSelectedColor;
  Color forOthersBorderColor = notSelectedColor;

  bool isForSelf = false;
  bool isForOthers = false;
  bool isDisplayForm = false;
  bool isDisplayContactDetailForm = false;

  //1 = my bank, 2 = others
  void updateBorderColor(int bankType) {
    //My bank

    if (bankType == 1) {
      if (forSelfBorderColor == notSelectedColor) {
        forSelfBorderColor = selectedColor;
        forOthersBorderColor = notSelectedColor;
      } else {
        forSelfBorderColor = notSelectedColor;
      }
    }

    //othher banks
    if (bankType == 2) {
      if (forOthersBorderColor == notSelectedColor) {
        forOthersBorderColor = selectedColor;
        forSelfBorderColor = notSelectedColor;
      } else {
        forOthersBorderColor = notSelectedColor;
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
                            isForSelf = true;
                          });
                        },
                  child: BankCard(
                    cardTitle: 'For Self',
                    icon: Icons.person,
                    borderColor: forSelfBorderColor,
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
                            isForOthers = true;
                          });
                        },
                  child: BankCard(
                    cardTitle: 'For Others',
                    icon: Icons.people,
                    borderColor: forOthersBorderColor,
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
                      color: forSelfBorderColor == selectedColor ||
                              forOthersBorderColor == selectedColor
                          ? Colors.blue
                          : Colors.grey,
                      onTap: forSelfBorderColor == selectedColor ||
                              forOthersBorderColor == selectedColor
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
                  child: isForSelf == true
                      ? Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: '08012345678',
                                prefixIcon: Icon(Icons.phone),
                                enabled: false,
                                border: OutlineInputBorder(),
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
                                'Recharge',
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
                                'Select Network Provider',
                                style: TextStyle(color: Colors.grey),
                              ),
                              items: _dropdownHelper.getISPDropdownItems(),
                              onChanged: (value) {
                                setState(() {
                                  _dropdownHelper.selectedISP = value;
                                  isDisplayContactDetailForm = true;
                                });
                              },
                            ),
                            isDisplayContactDetailForm == true
                                ? Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15),
                                        TextField(
                                          decoration: InputDecoration(
                                            hintText: 'Phone Number',
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(Icons.phone),
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
                                            'Recharge',
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
