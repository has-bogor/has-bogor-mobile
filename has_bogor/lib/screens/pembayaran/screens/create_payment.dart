import 'package:flutter/material.dart';
import 'package:has_bogor/screens/pembayaran/screens/update_payment.dart';
import 'package:has_bogor/screens/pembayaran/widgets/payment_form.dart';
import 'package:has_bogor/screens/pembayaran/widgets/payment_method_dropdown.dart';

class CreatePaymentScreen extends StatefulWidget {
  const CreatePaymentScreen({super.key});

  @override
  _CreatePaymentScreenState createState() => _CreatePaymentScreenState();
}

class _CreatePaymentScreenState extends State<CreatePaymentScreen> {
  String? selectedPaymentMethod;
  double totalAmount = 0.0;
  int quantity = 1;
  final TextEditingController amountController = TextEditingController();

  // Update total amount based on quantity and unit price
  void updateTotalAmount(double unitPrice) {
    setState(() {
      totalAmount = unitPrice * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    double unitPrice = 100000; // Example price, replace with actual product price

    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Pesanan", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo[900],
      ),
      body: Container(
        decoration:const  BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1D1E3C), Color(0xff004F8C)], // Gradient warna
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            color: Colors.indigo[900], // Background gelap untuk card 
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.7)], // Background gelap untuk card
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul Produk
                  Text(
                    "Produk: Nama Produk", 
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                  Text(
                    "Harga: Rp ${unitPrice.toString()}",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  
                  SizedBox(height: 20),
                  // Payment Form (Quantity and Amount Input)
                  PaymentForm(
                    amountController: amountController,
                    onQuantityChanged: (value) {
                      setState(() {
                        quantity = int.tryParse(value) ?? 1;
                        updateTotalAmount(unitPrice);
                      });
                    },
                  ),

                  SizedBox(height: 16),

                  // Payment Method Dropdown
                  PaymentMethodDropdown(
                    onChanged: (String? newMethod) {
                      setState(() {
                        selectedPaymentMethod = newMethod;
                      });
                    },
                  ),

                  SizedBox(height: 16),

                  // Total Pembayaran
                  Text(
                    "Total Pembayaran: Rp ${totalAmount.toString()}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),

                  SizedBox(height: 24),

                  // Tombol Pembayaran
                  ElevatedButton(
                    onPressed: () {
                      if (selectedPaymentMethod != null) {
                        // After clicking "Bayar", redirect to Update Payment Screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdatePaymentScreen(
                              paymentId: '123', // Example, replace with actual payment ID
                              totalPayment: totalAmount,
                              paymentMethod: selectedPaymentMethod!,
                              status: 'Pending',
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Silakan pilih metode pembayaran')));
                      }
                    },
                    child: Text("Bayar", style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[900],
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
