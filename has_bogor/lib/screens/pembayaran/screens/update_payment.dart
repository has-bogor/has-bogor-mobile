import 'package:flutter/material.dart';

class UpdatePaymentScreen extends StatelessWidget {
  final String paymentId;
  final double totalPayment;
  final String paymentMethod;
  final String status;

  UpdatePaymentScreen({
    required this.paymentId,
    required this.totalPayment,
    required this.paymentMethod,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pembayaran"),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1D1E3C), Color(0xff004F8C)], // Gradient warna
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              // Background Image with opacity
              Positioned.fill(
                child: Image.asset(
                  'assets/images/update.jpg',  // Pastikan gambar ada di folder 'assets/image'
                  fit: BoxFit.cover,
                  opacity: AlwaysStoppedAnimation(1),  // Set opacity to give a blur effect
                ),
              ),
              // Container for Payment Details
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center align the column
                      crossAxisAlignment: CrossAxisAlignment.center, // Center align the children
                      children: [
                        // Title
                        Text(
                          'Detail Pembayaran',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),

                        // Payment Information
                        Text(
                          'ID Pembayaran: $paymentId',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Total Pembayaran: Rp ${totalPayment.toString()}',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Metode Pembayaran: $paymentMethod',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Status Pembayaran: $status',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        SizedBox(height: 30),

                        // Action Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to Payment History
                                Navigator.pushNamed(context, '/payment-history');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              child: Text(
                                'Riwayat Pembayaran',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to Create Payment screen
                                Navigator.pushNamed(context, '/create-payment');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              child: Text(
                                'Buat Pembayaran Baru',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
