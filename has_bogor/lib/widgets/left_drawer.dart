import 'package:flutter/material.dart';
import 'package:has_bogor/screens/authentication/home.dart';
import 'package:has_bogor/screens/pembayaran/screens/payment_history.dart';

import 'package:has_bogor/screens/authentication/login.dart';
import 'package:has_bogor/screens/ulasan/screens/show_ulasan_page.dart';
import 'package:has_bogor/screens/ulasan/screens/ulasan_form_page.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            // Bagian drawer header
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                const Text(
                  'Has Bogor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Text(
                  "Ayo belanja produk terbaik kami!",
                  // Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.indigo[900],
                  ),

                ),
              ],
            ),
          ),
            // Bagian routing
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              // Bagian redirection ke MyHomePage
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  HomeScreen(),
                    ));
              },
            ),
            //todo:buat product
            // ListTile(
            //   leading: const Icon(Icons.shopping_cart_outlined),
            //   title: const Text('Product'),
            //   // Bagian redirection ke ProductScreen
            //   onTap: () {
            //     Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const ProductScreen(),
            //         ));
            //   },
            // ),
            //todo:buat ulasan
            ListTile(
              leading: const Icon(Icons.rate_review_outlined),
              title: const Text('Review'),
              // Bagian redirection ke ReviewScreen
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReviewScreen(),
                    ));
              },
            ),
            //todo:buat promo
            // ListTile(
            //   leading: const Icon(Icons.local_offer_outlined),
            //   title: const Text('Promo'),
            //   // Bagian redirection ke PromoScreen
            //   onTap: () {
            //     Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const PromoScreen(),
            //         ));
            //   },
            // ),
            //buat history pembayaran
            ListTile(
              leading: const Icon(Icons.payment_outlined),
              title: const Text('History'),
              // Bagian redirection ke PaymentHistoryPage
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  PaymentHistoryScreen(),
                    ));
              },
            ),
            //logout
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Bagian redirection ke LoginScreen
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginApp(),
                    ));
              },
            ),
        ],
      ),
    );
  }
}