import 'package:flutter/material.dart';
import 'package:has_bogor/screens/promo/promo_model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class PromoFormScreen extends StatefulWidget {
  final Promo? promo;

  const PromoFormScreen({Key? key, this.promo}) : super(key: key);

  @override
  _PromoFormScreenState createState() => _PromoFormScreenState();
}

class _PromoFormScreenState extends State<PromoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _kodeController;
  late TextEditingController _potonganController;
  late TextEditingController _masaBerlakuController;
  late TextEditingController _minimalTransaksiController;

  @override
  void initState() {
      super.initState();
      _kodeController = TextEditingController(text: widget.promo?.kode.toString() ?? '');
      _potonganController = TextEditingController(text: widget.promo?.potongan.toString() ?? '');
      _masaBerlakuController = TextEditingController(text: widget.promo?.masaBerlaku.toString() ?? '');
      _minimalTransaksiController = TextEditingController(text: widget.promo?.minimalTransaksi.toString() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.promo == null ? 'Create Promo' : 'Edit Promo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _kodeController,
              decoration: InputDecoration(labelText: 'Kode Promo'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a promo code';
                }
                if (int.tryParse(value) == null) {  // Validasi angka
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _potonganController,
              decoration: InputDecoration(labelText: 'Potongan (%)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter discount percentage';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _masaBerlakuController,
              decoration: InputDecoration(labelText: 'Masa Berlaku (hari)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter validity period';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _minimalTransaksiController,
              decoration: InputDecoration(labelText: 'Minimal Transaksi'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter minimum transaction';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _submitForm(context),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final request = context.read<CookieRequest>();
    
    try {
      final promo = Promo(
        id: widget.promo?.id,
        kode: int.parse(_kodeController.text),
        potongan: int.parse(_potonganController.text),
        masaBerlaku: int.parse(_masaBerlakuController.text),
        minimalTransaksi: int.parse(_minimalTransaksiController.text),
        tokoTerkait: widget.promo?.tokoTerkait ?? [],
      );

      if (widget.promo == null) {
        // Create new promo
        final response = await request.postJson(
          "http://localhost:8000/promo/create-promo-flutter/",
          jsonEncode(<String, String>{
            'kode': promo.kode.toString(),
            'potongan': promo.potongan.toString(),
            'masa_berlaku': promo.masaBerlaku.toString(),
            'minimal_transaksi': promo.minimalTransaksi.toString(),
            'toko_terkait': '[]',
          }),
        );

        if (context.mounted) {
          if (response['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Promo baru berhasil disimpan!")),
            );
            Navigator.pop(context, true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Terdapat kesalahan, silakan coba lagi."),
              ),
            );
          }
        }
      } else {
        // Edit existing promo
        final response = await request.postJson(
          "http://localhost:8000/promo/edit-promo-flutter/${widget.promo!.id}/",
          jsonEncode(<String, String>{
            'kode': promo.kode.toString(),
            'potongan': promo.potongan.toString(),
            'masa_berlaku': promo.masaBerlaku.toString(),
            'minimal_transaksi': promo.minimalTransaksi.toString(),
            'toko_terkait': '[]',
          }),
        );

        if (context.mounted) {
          if (response['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Promo berhasil diperbarui!")),
            );
            Navigator.pop(context, true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Terdapat kesalahan, silakan coba lagi."),
              ),
            );
          }
        }
      }
    } catch (e) {
      print('Error submitting form: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  void dispose() {
    _kodeController.dispose();
    _potonganController.dispose();
    _masaBerlakuController.dispose();
    _minimalTransaksiController.dispose();
    super.dispose();
  }
}