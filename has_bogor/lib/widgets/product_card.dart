import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final dynamic item; // Menerima data produk sebagai parameter

  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Ambil informasi produk dari 'item'
    final String productName = item['nama']; // Nama produk
    final double productPrice = item['harga'].toDouble(); // Harga produk
    final String productDescription = item['deskripsi']; // Deskripsi produk
    final String storeName = item['toko']; // Nama toko

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                // Deskripsi Produk
                Text(
                  productDescription,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                // Nama Toko
                Text(
                  "Dijual oleh: $storeName",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
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