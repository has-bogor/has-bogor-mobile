import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _amountController = TextEditingController();
  int _amount = 1;
  final int _productId = 123;  // Ganti dengan ID produk yang sesuai
  final double _productPrice = 100.0;  // Ganti dengan harga produk

  @override
  void initState() {
    super.initState();
    _amountController.text = _amount.toString();
  }

  // Fungsi untuk menangani klik "Beli Sekarang"
  void _buyNow() {
    // Simulasikan pembelian produk
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pembelian Sukses'),
          content: Text('Produk telah dibeli dengan jumlah $_amount'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menangani klik "Review"
  void _goToReview() {
    // Arahkan ke halaman review, misalnya menggunakan Navigator
    Navigator.pushNamed(context, '/review'); // Pastikan kamu memiliki rute /review di main.dart
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Produk Info (Nama, Harga)
            Text(
              'Nama Produk: Produk XYZ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Harga: \$$_productPrice',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Form Pembayaran
            Text('Masukkan jumlah yang ingin dibeli:', style: TextStyle(color: Colors.grey)),
            Row(
              children: [
                // Jumlah Pembelian
                Container(
                  width: 60,
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      hintText: '1',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _amount = int.tryParse(value) ?? 1;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                // Tombol Beli Sekarang
                ElevatedButton(
                  onPressed: _buyNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[500],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Beli Sekarang'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Tombol Lainnya
            Row(
              children: [
                // Tombol Beli Sekarang
                Expanded(
                  child: ElevatedButton(
                    onPressed: _buyNow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[500],
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Beli Sekarang'),
                  ),
                ),
                SizedBox(width: 16),
                // Tombol Review
                Expanded(
                  child: ElevatedButton(
                    onPressed: _goToReview,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[500],
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Review'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
