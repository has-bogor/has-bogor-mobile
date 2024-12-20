import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Katalog Produk'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final String store;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.store,
  });
}

final List<Product> products = [
  Product(
    id: 1,
    name: 'Asinan Bogor',
    description: 'Campuran buah dan sayur dalam kuah asam manis pedas, khas Bogor',
    price: 'Rp 25,000.00',
    store: 'Pergi Kuliner',
  ),
  Product(
    id: 2,
    name: 'Roti Unyil Venus',
    description: 'Roti mini dengan berbagai varian rasa, populer sejak 1978',
    price: 'Rp 15,000.00',
    store: 'Pergi Kuliner',
  ),
  Product(
    id: 3,
    name: 'Talas Bogor',
    description: 'Umbi-umbian khas Bogor yang diolah menjadi berbagai makanan',
    price: 'Rp 20,000.00',
    store: 'Superkue',
  ),
];

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product});

  Future<void> addToWishlist(CookieRequest request, int productId) async {
    final url = 'http://127.0.0.1:8000/wishlist/api/add/$productId/';
    try {
      final response = await request.post(url, {});
      if (response['status'] == 'success') {
        print('Produk berhasil ditambahkan ke wishlist');
      } else {
        print('Gagal menambahkan ke wishlist: ${response['message']}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              product.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
            Spacer(),
            Text(
              product.price,
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Toko: ${product.store}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Beli Sekarang'),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () => addToWishlist(request, product.id),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
