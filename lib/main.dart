import 'package:flutter/material.dart';
import 'package:mobile_banking/routes/routes.dart';
import 'package:mobile_banking/screens/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: myRoute,
      initialRoute: Dashboard.id,
    );
  }
}
