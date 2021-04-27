import 'package:flutter/material.dart';
import 'package:mobile_banking/screens/banking_action.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({
    Key key,
    this.icon,
    this.cardTitle,
  }) : super(key: key);

  final IconData icon;
  final String cardTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return BankingAction(headerTitle: cardTitle);
            },
          ),
        );
      },
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[300]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              cardTitle,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            CircleAvatar(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
