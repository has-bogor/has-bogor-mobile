// product_card.dart
import 'package:flutter/material.dart';
import '../models/katalogs.dart';

class ProductCard extends StatelessWidget {
  final Katalog katalog;
  final VoidCallback onBeli;
  final VoidCallback onWishlist;
  final VoidCallback onReview;

  const ProductCard({
    Key? key,
    required this.katalog,
    required this.onBeli,
    required this.onWishlist,
    required this.onReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/slide1.jpg',
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            
            // Nama produk
            Text(
              katalog.nama,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Kategori
            Text(
              "Kategori ${katalog.kategori}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            
            // Harga
            Text(
              "Rp ${katalog.harga}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            
            // Deskripsi
            Text(
              katalog.deskripsi,
              style: const TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Toko
            Text(
              "Toko: ${katalog.toko}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            
            const Spacer(),
            
            // Button row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: onBeli,
                  color: Colors.blue,
                  tooltip: 'Beli Sekarang',
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: onWishlist,
                  color: Colors.red,
                  tooltip: 'Tambah ke Wishlist',
                ),
                IconButton(
                  icon: const Icon(Icons.rate_review),
                  onPressed: onReview,
                  color: Colors.green,
                  tooltip: 'Tulis Review',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}