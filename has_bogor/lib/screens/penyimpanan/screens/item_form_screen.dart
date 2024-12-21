import 'package:flutter/material.dart';
import '../models/katalog_model.dart';
import '../services/api_service.dart';

class ItemFormScreen extends StatefulWidget {
  final Katalog? item; // Null if adding, non-null if editing

  const ItemFormScreen({Key? key, this.item}) : super(key: key);

  @override
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  late TextEditingController namaController;
  late TextEditingController hargaController;
  late TextEditingController kategoriController;
  late TextEditingController deskripsiController;
  late TextEditingController tokoController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data for editing
    namaController = TextEditingController(text: widget.item?.nama ?? '');
    hargaController = TextEditingController(text: widget.item?.harga.toString() ?? '');
    kategoriController = TextEditingController(text: widget.item?.kategori.toString() ?? '');
    deskripsiController = TextEditingController(text: widget.item?.deskripsi ?? '');
    tokoController = TextEditingController(text: widget.item?.toko ?? '');
  }

  @override
  void dispose() {
    namaController.dispose();
    hargaController.dispose();
    kategoriController.dispose();
    deskripsiController.dispose();
    tokoController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newItem = Katalog(
        id: widget.item?.id ?? 0, // Use 0 for new items
        nama: namaController.text,
        harga: double.parse(hargaController.text),
        kategori: int.parse(kategoriController.text),
        deskripsi: deskripsiController.text,
        toko: tokoController.text,
      );

      try {
        if (widget.item == null) {
          await apiService.addItem(newItem); // Add item
        } else {
          await apiService.updateItem(widget.item!.id, newItem); // Update item
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Item saved successfully!"),
        ));
        Navigator.pop(context, true); // Return to the previous screen
      } catch (e) {
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to save item. Please try again."),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item == null ? "Add Item" : "Edit Item")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) => value!.isEmpty ? "Name is required" : null,
              ),
              TextFormField(
                controller: hargaController,
                decoration: InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Price is required" : null,
              ),
              TextFormField(
                controller: kategoriController,
                decoration: InputDecoration(labelText: "Category ID"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Category ID is required" : null,
              ),
              TextFormField(
                controller: deskripsiController,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) => value!.isEmpty ? "Description is required" : null,
              ),
              TextFormField(
                controller: tokoController,
                decoration: InputDecoration(labelText: "Store"),
                validator: (value) => value!.isEmpty ? "Store is required" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.item == null ? "Add" : "Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}