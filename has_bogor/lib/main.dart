import 'package:flutter/material.dart';
import 'package:has_bogor/screens/authentication/screens/guestpage.dart';
import 'package:provider/provider.dart';
import 'package:has_bogor/screens/authentication/screens/login.dart';
import 'package:has_bogor/screens/authentication/screens/home.dart';
import 'package:has_bogor/screens/authentication/screens/register.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:has_bogor/screens/pembayaran/screens/payment_history.dart';
import 'package:has_bogor/screens/penyimpanan/screens/katalog_screen.dart';

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
          // Update color scheme untuk tema yang lebih konsisten
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            primary: Colors.indigo[900]!,
            secondary: const Color(0xff1D1E3C),
            background: const Color(0xff004F8C),
            // Tambahkan warna untuk dark mode
            brightness: Brightness.dark,
          ),
          // Kustomisasi tema untuk komponen-komponen umum
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.indigo[900],
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          // Kustomisasi card theme
          cardTheme: CardTheme(
            color: Colors.black.withOpacity(0.7),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          // Kustomisasi elevated button theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[900],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          // Text theme untuk konsistensi typography
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ),
        // Routes untuk navigasi
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomePage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/home': (context) => const HomeScreen(),
          '/payment-history': (context) => const PaymentHistoryScreen(),
          '/katalog': (context) => const KatalogScreen(),
        },
        // Error handling untuk routes yang tidak ditemukan
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: const Center(
                child: Text('Halaman tidak ditemukan'),
              ),
            ),
          );
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}