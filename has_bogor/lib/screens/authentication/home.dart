import 'package:flutter/material.dart';
import 'package:has_bogor/widgets/left_drawer.dart';

class HomeScreen extends StatelessWidget {
  final String userName = "Bogorlovers";

  // Tambahkan GlobalKey untuk mengontrol Drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Tambahkan key pada Scaffold
      //todo: gradient background
      backgroundColor: Colors.transparent, // Menghilangkan warna background default
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1D1E3C), Color(0xff004F8C)],  // Gradien yang diinginkan
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Transparent untuk gradien
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer(); // Gunakan key untuk membuka drawer
              },
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const LeftDrawer(),  // Menampilkan LeftDrawer
      body: SingleChildScrollView(
        child: Container(
          // Menggunakan gradien di seluruh background
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1D1E3C), Color(0xff004F8C)],  // Gradien yang diinginkan
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Text
              Text(
                "Welcome Back, $userName!",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,  // Text berwarna putih agar terlihat di gradien gelap
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Explore the best products for you",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 20),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search for products...",
                  prefixIcon: const Icon(Icons.search, color: Colors.black54),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Promo Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Special Promo!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Enjoy up to 50% off on selected items.",
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      "assets/images/promo.jpeg", // Gambar promo
                      height: 80,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Catalog Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Katalog Produk",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Logika untuk View All
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Product Cards (Scroll horizontally)
              SizedBox(
                height: 210, // Tinggi diperbaiki untuk menghindari overflow
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Jumlah produk
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(
                        productName: "Produk ${index + 1}",
                        price: "Rp ${(index + 1) * 10000}",
                        imageUrl: "assets/images/slide1.jpg",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget: Product Card
class ProductCard extends StatelessWidget {
  final String productName;
  final String price;
  final String imageUrl;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              imageUrl,
              height: 100, // Sesuaikan tinggi gambar
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                // Tombol Lihat Detail Produk
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Logika untuk lihat detail produk
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Lihat Detail $productName")),
                      );
                    },
                    child: const Text(
                      "Lihat Detail",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                // Tombol Keranjang
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      // Logika tombol beli
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Beli $productName berhasil!")),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
