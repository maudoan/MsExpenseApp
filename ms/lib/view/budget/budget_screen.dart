import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  @override
  _BudgetState createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: Text('Budget'),
      ),
    );
  }
}
