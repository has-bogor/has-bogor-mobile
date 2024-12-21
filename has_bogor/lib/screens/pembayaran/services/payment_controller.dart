import 'package:flutter/material.dart';
import 'package:has_bogor/screens/pembayaran/services/services.dart' as payment_service;
import 'package:has_bogor/screens/pembayaran/models/models.dart';

class PaymentController with ChangeNotifier {
  bool _isLoading = false;
  String _paymentStatus = '';
  List<Payment> _payments = [];

  bool get isLoading => _isLoading;
  String get paymentStatus => _paymentStatus;
  List<Payment> get payments => _payments;

  final payment_service.PaymentService paymentService = payment_service.PaymentService();

  Future<void> createPayment(double amount, String paymentMethod) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool success = await paymentService.createPayment(amount, paymentMethod);
      _paymentStatus = success ? 'Pembayaran Berhasil' : 'Pembayaran Gagal';
    } catch (e) {
      _paymentStatus = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePayment(String paymentId) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool success = await paymentService.deletePayment(paymentId);
      _paymentStatus = success ? 'Pembayaran dihapus' : 'Gagal menghapus pembayaran';
    } catch (e) {
      _paymentStatus = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPayments() async {
    _isLoading = true;
    notifyListeners();
    try {
      List<Map<String, dynamic>> paymentMaps = await paymentService.getPayments();
      _payments = paymentMaps.map((map) => Payment.fromJson(map)).toList();
    } catch (e) {
      _paymentStatus = 'Gagal mengambil riwayat pembayaran: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}