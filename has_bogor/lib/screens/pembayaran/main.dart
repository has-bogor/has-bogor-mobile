import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:has_bogor/screens/pembayaran/services/payment_controller.dart';
import 'package:has_bogor/screens/pembayaran/screens/payment_history.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PaymentController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaymentHistoryScreen(),
    );
  }
}