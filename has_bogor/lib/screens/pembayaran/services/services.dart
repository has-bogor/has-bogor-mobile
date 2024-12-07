import 'dart:convert'; // Untuk parsing data JSON
import 'package:http/http.dart' as http;

class PaymentService {
  // URL API pembayaran
  final String apiUrl = 'https://api.example.com/payments'; // Ganti dengan URL API asli

  // Fungsi untuk membuat pembayaran
  Future<bool> createPayment(double amount, String paymentMethod) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'amount': amount,
          'paymentMethod': paymentMethod,
        }),
      );

      if (response.statusCode == 200) {
        // Jika status code 200, pembayaran berhasil
        return true;
      } else {
        // Jika status code bukan 200, pembayaran gagal
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // Fungsi untuk menghapus pembayaran
  Future<bool> deletePayment(String paymentId) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/$paymentId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Jika status code 200, penghapusan berhasil
        return true;
      } else {
        // Jika status code bukan 200, penghapusan gagal
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
