import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final dynamic item; // Menerima data produk sebagai parameter

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Ambil informasi produk dari 'item'
    final String productName = item['name']; // Misalnya, nama produk ada di field 'name'
    final String productImage = item['image']; // Misalnya, URL gambar produk ada di field 'image'
    final double productPrice = item['price'].toDouble(); // Misalnya, harga produk ada di field 'price'

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Produk
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              productImage, // Menggunakan URL gambar produk
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Produk
                Text(
                  productName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                // Harga Produk
                Text(
                  "Rp ${productPrice.toStringAsFixed(0)}", // Format harga tanpa desimal
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Tombol Aksi, misalnya "Tambah ke Keranjang"
                ElevatedButton(
                  onPressed: () {
                    // Fungsi untuk menambahkan produk ke keranjang atau melihat detail
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.indigo[700], // Warna tombol
                  ),
                  child: const Text("Tambah ke Keranjang"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
