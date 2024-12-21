import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/category.dart';

class CategoryFormPage extends StatefulWidget {
  final bool isEdit;
  final Category? category;

  const CategoryFormPage({super.key, required this.isEdit, this.category});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _categoryName = '';

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.category != null) {
      _categoryName = widget.category!.namaCategory;
    }
  }

  void showSnackBarMessage(String message, {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final payload = jsonEncode({'nama_category': _categoryName});

      if (widget.isEdit && widget.category != null) {
        final url = "http://127.0.0.1:8000/category/categories/update/${widget.category!.id}/";
        final response = await http.put(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer YOUR_TOKEN',
          },
          body: payload,
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if (responseData['success']) {
            showSnackBarMessage(responseData['message']);
            Navigator.pop(context);
          } else {
            showSnackBarMessage(responseData['message'] ?? "Error updating category", color: Colors.red);
          }
        } else {
          showSnackBarMessage("Error updating category, status code: ${response.statusCode}", color: Colors.red);
        }
      } else {
        final url = "http://127.0.0.1:8000/category/categories/create/";
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer YOUR_TOKEN',
          },
          body: payload,
        );

        if (response.statusCode == 201) {
          final responseData = json.decode(response.body);
          if (responseData['success']) {
            showSnackBarMessage(responseData['message']);
            Navigator.pop(context);
          } else {
            showSnackBarMessage(responseData['message'] ?? "Error creating category", color: Colors.red);
          }
        } else {
          showSnackBarMessage("Error creating category, status code: ${response.statusCode}", color: Colors.red);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.isEdit ? 'Edit Category' : 'Add Category'),
      backgroundColor: Color(0xff004F8C),  // Set the AppBar color
    ),
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height, // Ensure full screen height
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1D1E3C), Color(0xff004F8C)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Title Text
            Text(
              widget.isEdit ? 'Edit Category' : 'Add Category',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Form Fields
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _categoryName,
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSaved: (value) {
                      _categoryName = value!.trim();
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Category name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),

                  // Submit Button
                  ElevatedButton(
                    onPressed: submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff004F8C),  // Set button color
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      widget.isEdit ? 'Update Category' : 'Add Category',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}}
