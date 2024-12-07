import 'package:flutter/material.dart';
import 'package:has_bogor/screens/pembayaran/screens/create_payment.dart'; // Import untuk CreatePaymentScreen
import 'package:has_bogor/screens/pembayaran/screens/delete_payment.dart';

class PaymentHistoryScreen extends StatelessWidget {
  // Example payment data (replace with actual data from backend)
  final List<Map<String, String>> payments = [
    {'id': '1', 'product': 'Produk A', 'status': 'Berhasil', 'amount': '2', 'total': '200000'},
    {'id': '2', 'product': 'Produk B', 'status': 'Pending', 'amount': '1', 'total': '100000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pembayaran"),
        backgroundColor: Colors.indigo[900],
      ),
      // Background gradient full screen
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1D1E3C), Color(0xff004F8C)], // Gradient warna
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              const Text(
                "Riwayat Pembayaran",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10), // Jarak yang lebih kecil

              // Container untuk DataTable dengan border-radius dan shadow
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7), // Background gelap untuk card
                      borderRadius: BorderRadius.circular(15), // Border radius untuk card
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 8,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // Membuat scrolling horizontal
                      child: DataTable(
                        columnSpacing: 10,  // Menyesuaikan jarak antar kolom
                        horizontalMargin: 12,  // Menyesuaikan margin horizontal
                        dataRowHeight: 40, // Menyesuaikan tinggi baris
                        columns: const [
                          DataColumn(label: Text('ID Pembayaran', style: TextStyle(color: Colors.white))),
                          DataColumn(label: Text('Produk', style: TextStyle(color: Colors.white))),
                          DataColumn(label: Text('Status', style: TextStyle(color: Colors.white))),
                          DataColumn(label: Text('Jumlah', style: TextStyle(color: Colors.white))),
                          DataColumn(label: Text('Total', style: TextStyle(color: Colors.white))),
                          DataColumn(label: Text('Aksi', style: TextStyle(color: Colors.white))),
                        ],
                        rows: payments.map((payment) {
                          return DataRow(
                            cells: [
                              DataCell(Text(payment['id'] ?? '', style: const TextStyle(color: Colors.white))),
                              DataCell(Text(payment['product'] ?? '', style: const TextStyle(color: Colors.white))),
                              DataCell(Text(payment['status'] ?? '', style: const TextStyle(color: Colors.white))),
                              DataCell(Text(payment['amount'] ?? '', style: const TextStyle(color: Colors.white))),
                              DataCell(Text('Rp ${payment['total']}', style: const TextStyle(color: Colors.white))),
                              DataCell(IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Navigasi ke layar penghapusan pembayaran
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DeletePaymentScreen(paymentId: payment['id']!),
                                    ),
                                  );
                                },
                              )),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Redirect ke halaman CreatePaymentScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePaymentScreen(),
            ),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
