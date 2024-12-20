import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'promo_model.dart';
import 'promoForm.dart';
import 'promo_card.dart';
import 'dart:convert';

class PromoScreen extends StatefulWidget {
  const PromoScreen({Key? key}) : super(key: key);

  @override
  _PromoScreenState createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen> {
  List<Promo> _promos = [];
  String _sortBy = "tanpa_filter";

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _loadPromos(context));
  }

  Future<void> _loadPromos(BuildContext context) async {
    final request = context.read<CookieRequest>();
    try {
      final String endpoint = _sortBy == "tanpa_filter" 
          ? 'http://127.0.0.1:8000/promo/show_json' 
          : 'http://127.0.0.1:8000/promo/filtered/?sort_by=$_sortBy';
          
      final response = await request.get(endpoint);

      List<Promo> promos = (response as List)
          .map((item) => Promo.fromJson(item))
          .toList();

      setState(() {
        _promos = promos;
      });
    } catch (e, stackTrace) {
      print('Error details: $e');
      print('Stack trace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PromoFormScreen(),
                ),
              ).then((value) {
                if (value == true) {
                  _loadPromos(context);
                }
              });
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _sortBy = value;
                _loadPromos(context);
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'tanpa_filter',
                child: Text('No Filter'),
              ),
              PopupMenuItem(
                value: 'masa_berlaku',
                child: Text('By Expiry Date'),
              ),
              PopupMenuItem(
                value: 'potongan',
                child: Text('By Discount'),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadPromos(context),
        child: ListView.builder(
          itemCount: _promos.length,
          itemBuilder: (context, index) {
            final promo = _promos[index];
            return PromoCard(
              promo: promo,
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PromoFormScreen(promo: promo),
                  ),
                ).then((value) {
                  if (value == true) {
                    _loadPromos(context);
                  }
                });
              },
              onDelete: () => _deletePromo(context, promo.id!),
              onAddStore: () => _addStore(context, promo.id!),
              onRemoveStore: (String storeName) => _removeStore(context, promo.id!, storeName),
            );
          },
        ),
      ),
    );
  }

  Future<void> _deletePromo(BuildContext context, String id) async {
    final request = context.read<CookieRequest>();
    try {
      final response = await request.postJson(
        "http://127.0.0.1:8000/promo/delete-flutter/$id/",
        jsonEncode(<String, dynamic>{}),  // Empty JSON object
      );

      if (context.mounted) {
        if (response['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Promo berhasil dihapus!")),
          );
          _loadPromos(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['message'] ?? "Terdapat kesalahan, silakan coba lagi."),
            ),
          );
        }
      }
    } catch (e) {
      print('Error deleting promo: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Terdapat kesalahan, silakan coba lagi."),
          ),
        );
      }
    }
  }

  Future<void> _addStore(BuildContext context, String promoId) async {
    final _namaController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tambah Toko'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _namaController,
            decoration: InputDecoration(labelText: 'Nama Toko'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Harap isi nama toko';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: Text('Tambah'),
          ),
        ],
      ),
    );

    if (result == true) {
      final request = context.read<CookieRequest>();
      try {
        final response = await request.postJson(
          "http://127.0.0.1:8000/promo/add-store-flutter/$promoId/",
          jsonEncode({
            'nama': {'name': _namaController.text},  // Sesuaikan format JSON
          }),
        );

        if (context.mounted) {
          if (response['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Toko berhasil ditambahkan!")),
            );
            _loadPromos(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(response['message'] ?? "Gagal menambahkan toko.")),
            );
          }
        }
      } catch (e) {
        print('Error adding store: $e');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gagal menambahkan toko.")),
          );
        }
      }
    }
}

Future<void> _removeStore(BuildContext context, String promoId, String storeName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Toko'),
        content: Text('Yakin ingin menghapus toko "$storeName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Hapus'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final request = context.read<CookieRequest>();
      try {
        final response = await request.postJson(
          "http://127.0.0.1:8000/promo/remove-store-flutter/$promoId/",
          jsonEncode({'storeName': storeName}),
        );

        if (context.mounted) {
          if (response['status'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Toko berhasil dihapus!")),
            );
            _loadPromos(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response['message'] ?? "Gagal menghapus toko."),
              ),
            );
          }
        }
      } catch (e) {
        print('Error removing store: $e');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gagal menghapus toko.")),
          );
        }
      }
    }
}
}

