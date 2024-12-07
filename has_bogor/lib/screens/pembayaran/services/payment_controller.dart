import 'package:flutter/material.dart';
import 'package:has_bogor/screens/pembayaran/services/services.dart';

class PaymentController with ChangeNotifier {
  bool _isLoading = false;
  String _paymentStatus = '';
  final double _totalAmount = 0.0;

  bool get isLoading => _isLoading;
  String get paymentStatus => _paymentStatus;
  double get totalAmount => _totalAmount;

  final PaymentService paymentService = PaymentService();

  // Fungsi untuk membuat pembayaran
  Future<void> createPayment(double amount, String paymentMethod) async {
    _isLoading = true;
    notifyListeners();  // Notifikasi perubahan state ke UI
    try {
      bool success = await paymentService.createPayment(amount, paymentMethod);

      if (success) {
        _paymentStatus = 'Pembayaran Berhasil';
      } else {
        _paymentStatus = 'Pembayaran Gagal';
      }
    } catch (e) {
      _paymentStatus = 'Terjadi kesalahan';
    } finally {
      _isLoading = false;
      notifyListeners();  // Notifikasi perubahan state ke UI
    }
  }

  // Fungsi untuk menghapus pembayaran
  Future<void> deletePayment(String paymentId) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool success = await paymentService.deletePayment(paymentId);

      if (success) {
        _paymentStatus = 'Pembayaran dihapus';
      } else {
        _paymentStatus = 'Gagal menghapus pembayaran';
      }
    } catch (e) {
      _paymentStatus = 'Terjadi kesalahan';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
