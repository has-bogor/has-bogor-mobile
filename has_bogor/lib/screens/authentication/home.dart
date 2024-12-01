import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  late List<dynamic> katalogItems;

  @override
  void initState() {
    super.initState();
    katalogItems = [];
    fetchKatalogItems();
  }

  // Fungsi untuk mengambil data produk dari backend
  Future<void> fetchKatalogItems() async {
    var url = Uri.parse('http://127.0.0.1:8000/api/products/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        katalogItems = data;  // Menyimpan data produk ke dalam katalogItems
      });
    } else {
      throw Exception('Failed to load katalog items');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.indigo[500], // Ganti dengan indigo[500]
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Column(
                children: [
                  Text(
                    "Welcome to Has Bogor!",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[500], // Ganti dengan indigo[500]
                      fontFamily: 'DM Sans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Hello, bogorlovers! You are logged in.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Temukan berbagai produk menarik yang kami tawarkan. Nikmati pengalaman berbelanja dengan penawaran spesial setiap hari!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white, thickness: 1),
            
            // Promo Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo[500]!, Colors.indigo[400]!], // Ganti dengan indigo shades
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Promo Spesial!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Dapatkan penawaran menarik setiap hari!",
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 16),
                  Image.asset('assets/images/promo.jpeg', width: double.infinity, height: 200, fit: BoxFit.cover),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add navigation for promo page
                    },
                    child: Text("Lihat Promo"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[900], 
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white, thickness: 1),

            // Katalog Produk Section
            const Padding(
              padding:  EdgeInsets.all(16.0),
              child: Text(
                "Katalog Produk",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Grid View untuk menampilkan produk
            katalogItems.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: katalogItems.length,
                    itemBuilder: (context, index) {
                      var item = katalogItems[index];
                      return ProductCard(item: item);
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

// Widget untuk menampilkan produk
class ProductCard extends StatelessWidget {
  final dynamic item;

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: NetworkImage(item['image'] ?? 'https://via.placeholder.com/150'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item['name'] ?? 'Product Name',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Rp ${item['price']}',
              style: TextStyle(color: Colors.green[400], fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Text(
              item['description'] ?? 'No Description',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Logic for "Beli Sekarang"
              },
              child: Text("Beli Sekarang"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[500],
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
