import 'package:flutter/material.dart';
import 'package:mobile_banking/widgets/dashboard_card.dart';

class Dashboard extends StatefulWidget {
  static String id = '/dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      cardTitle: 'Transfer',
                      icon: Icons.swap_vert,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: DashboardCard(
                      cardTitle: 'Airtime',
                      icon: Icons.credit_card,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      cardTitle: 'Withdraw',
                      icon: Icons.money,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
