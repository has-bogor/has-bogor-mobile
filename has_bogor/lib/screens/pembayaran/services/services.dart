import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  final String apiUrl = 'http://127.0.0.1:8000/pembayaran/api/history/';

  Future<List<Map<String, dynamic>>> getPayments() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load payments. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching payments: $e');
    }
  }

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

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error creating payment: $e');
    }
  }

  Future<bool> deletePayment(String paymentId) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/$paymentId'),
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error deleting payment: $e');
    }
  }
}