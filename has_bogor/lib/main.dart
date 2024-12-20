import 'package:flutter/material.dart';
import 'package:has_bogor/screens/authentication/guestpage.dart';
import 'package:has_bogor/screens/pembayaran/screens/create_payment.dart';
import 'package:provider/provider.dart';
import 'package:has_bogor/screens/authentication/login.dart';
import 'package:has_bogor/screens/authentication/home.dart';
import 'package:has_bogor/screens/authentication/register.dart'; // Import halaman Register
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:has_bogor/screens/pembayaran/screens/payment_history.dart'; // Import PaymentHistoryScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Has Bogor',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
          ).copyWith(secondary: const Color.fromARGB(255, 36, 37, 66)),
        ),
        initialRoute: '/', // Halaman awal yang akan ditampilkan
        routes: {
          '/': (context) => const WelcomePage(), // Halaman Login
          '/login': (context) => const LoginPage(), // Halaman Login
          '/register': (context) => const RegisterPage(), // Halaman Register
          '/home': (context) =>    HomeScreen(), // Halaman Home
          '/payment-history': (context) =>  PaymentHistoryScreen(), // Halaman Payment History
          '/create-payment': (context) =>  const CreatePaymentScreen(), // Halaman Payment History
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
