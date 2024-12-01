import 'package:flutter/material.dart';

class CreatePaymentPage extends StatefulWidget {
  final Map<String, dynamic> product;  // Mengambil data produk

  const CreatePaymentPage({Key? key, required this.product}) : super(key: key);

  @override
  _CreatePaymentPageState createState() => _CreatePaymentPageState();
}

class _CreatePaymentPageState extends State<CreatePaymentPage> {
  int amount = 1;
  late int totalPayment;
  String selectedPaymentMethod = "";
  List<Map<String, String>> paymentMethods = [
    {"name": "Bank Transfer", "value": "bank_transfer"},
    {"name": "Credit Card", "value": "credit_card"},
    {"name": "E-Wallet", "value": "e_wallet"},
    {"name": "OVO", "value": "ovo"},
    {"name": "GoPay", "value": "gopay"},
    {"name": "Dana", "value": "dana"},
    {"name": "LinkAja", "value": "linkaja"},
  ];
  final _paymentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    totalPayment = widget.product['harga'];
  }

  void updateTotal() {
    setState(() {
      totalPayment = widget.product['harga'] * amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Pesanan'),
        backgroundColor: Colors.indigo[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Info Section
                Text(
                  'Produk: ${widget.product['nama']}',
                  style: TextStyle(color: Colors.indigo[200], fontSize: 18),
                ),
                Text(
                  'Harga: Rp${widget.product['harga']}',
                  style: TextStyle(color: Colors.indigo[200], fontSize: 16),
                ),
                SizedBox(height: 20),

                // Quantity Input
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Jumlah:',
                      style: TextStyle(color: Colors.indigo[200], fontSize: 16),
                    ),
                    Container(
                      width: 60,
                      child: TextField(
                        controller: TextEditingController(text: amount.toString()),
                        onChanged: (value) {
                          setState(() {
                            amount = int.tryParse(value) ?? 1;
                          });
                          updateTotal();
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[700],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Total Payment Section
                Text(
                  'Total Pembayaran: Rp$totalPayment',
                  style: TextStyle(color: Colors.indigo[200], fontSize: 18),
                ),
                SizedBox(height: 20),

                // Payment Method Search and Suggestions
                TextField(
                  controller: _paymentController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Pilih Metode Pembayaran',
                    labelStyle: TextStyle(color: Colors.indigo[200]),
                    filled: true,
                    fillColor: Colors.indigo[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (text) {
                    setState(() {
                      selectedPaymentMethod = text;
                    });
                  },
                ),
                SizedBox(height: 10),
                
                // Payment Suggestions List
                selectedPaymentMethod.isNotEmpty
                    ? Container(
                        height: 100,
                        child: ListView.builder(
                          itemCount: paymentMethods
                              .where((method) => method['name']!
                                  .toLowerCase()
                                  .contains(selectedPaymentMethod.toLowerCase()))
                              .length,
                          itemBuilder: (context, index) {
                            var method = paymentMethods
                                .where((method) => method['name']!
                                    .toLowerCase()
                                    .contains(selectedPaymentMethod.toLowerCase()))
                                .toList()[index];
                            return ListTile(
                              title: Text(
                                method['name']!,
                                style: TextStyle(color: Colors.indigo[200]),
                              ),
                              onTap: () {
                                setState(() {
                                  _paymentController.text = method['name']!;
                                  selectedPaymentMethod = method['value']!;
                                });
                              },
                            );
                          },
                        ),
                      )
                    : Container(),

                // Submit Button
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (selectedPaymentMethod.isEmpty) {
                      // Add validation or show an error
                      return;
                    }
                    // Proceed to submit the payment form
                    // You can use HTTP requests or navigation as needed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[600],
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Text(
                    'Bayar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),

                // Link to Payment History
                SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to payment history screen
                    },
                    child: Text(
                      'Kembali ke Riwayat Pembayaran',
                      style: TextStyle(color: Colors.indigo[300], fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
