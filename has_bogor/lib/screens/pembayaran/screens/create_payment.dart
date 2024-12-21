import 'package:flutter/material.dart';
import 'package:has_bogor/screens/pembayaran/screens/update_payment.dart';
import 'package:has_bogor/screens/pembayaran/widgets/payment_form.dart';
import 'package:has_bogor/screens/pembayaran/widgets/payment_method_dropdown.dart';
import 'package:has_bogor/screens/penyimpanan/models/katalog_model.dart'; 

class CreatePaymentScreen extends StatefulWidget {
  final Katalog katalog; // Tambah parameter katalog

  const CreatePaymentScreen({
    super.key, 
    required this.katalog, // Tambah required parameter
  });

  @override
  _CreatePaymentScreenState createState() => _CreatePaymentScreenState();
}

class _CreatePaymentScreenState extends State<CreatePaymentScreen> {
  String? selectedPaymentMethod;
  double totalAmount = 0.0;
  int quantity = 1;
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inisialisasi total amount saat screen dibuka
    updateTotalAmount(widget.katalog.harga);
  }

  // Update total amount based on quantity and unit price
  void updateTotalAmount(double unitPrice) {
    setState(() {
      totalAmount = unitPrice * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    double unitPrice = widget.katalog.harga; // Menggunakan harga dari katalog

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Pesanan", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1D1E3C), Color(0xff004F8C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Tambah SingleChildScrollView untuk mencegah overflow
          child: Center(
            child: Card(
              color: Colors.indigo[900],
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Informasi Produk
                    Text(
                      "Produk: ${widget.katalog.nama}",  // Menggunakan nama dari katalog
                      style: const TextStyle(
                        fontSize: 20, 
                        color: Colors.white, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Kategori: ${widget.katalog.kategori}",  // Menampilkan kategori
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Toko: ${widget.katalog.toko}",  // Menampilkan toko
                      style: const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Harga: Rp ${widget.katalog.harga}",  // Menggunakan harga dari katalog
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    
                    const SizedBox(height: 20),

                    // Deskripsi Produk
                    const Text(
                      "Deskripsi Produk:",
                      style: TextStyle(
                        fontSize: 16, 
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.katalog.deskripsi,  // Menampilkan deskripsi
                      style: const TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    
                    const SizedBox(height: 20),

                    // Payment Form
                    PaymentForm(
                      amountController: amountController,
                      onQuantityChanged: (value) {
                        setState(() {
                          quantity = int.tryParse(value) ?? 1;
                          updateTotalAmount(unitPrice);
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Payment Method Dropdown
                    PaymentMethodDropdown(
                      onChanged: (String? newMethod) {
                        setState(() {
                          selectedPaymentMethod = newMethod;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Total Pembayaran
                    Text(
                      "Total Pembayaran: Rp ${totalAmount.toStringAsFixed(2)}",  // Format angka desimal
                      style: const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.white
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tombol Pembayaran
                    ElevatedButton(
                      onPressed: () {
                        if (selectedPaymentMethod != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePaymentScreen(
                                paymentId: DateTime.now().millisecondsSinceEpoch.toString(), // Generate unique ID
                                totalPayment: totalAmount,
                                paymentMethod: selectedPaymentMethod!,
                                status: 'Pending',
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Silakan pilih metode pembayaran')
                            )
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[900],
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                      child: const Text(
                        "Bayar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}