import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:has_bogor/screens/authentication/login.dart';
import 'package:has_bogor/screens/authentication/home.dart';
import 'package:has_bogor/screens/authentication/register.dart'; // Import halaman Register
import 'package:pbp_django_auth/pbp_django_auth.dart';

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
          ).copyWith(secondary: Color.fromARGB(255, 36, 37, 66)),
        ),
        initialRoute: '/', // Halaman awal yang akan ditampilkan
        routes: {
          '/': (context) => LoginScreen(), // Halaman Login
          '/register': (context) => RegisterScreen(), // Halaman Register
          '/home': (context) => HomeScreen(), // Halaman Home
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
