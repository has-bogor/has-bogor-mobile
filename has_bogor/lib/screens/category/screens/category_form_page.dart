// lib/screens/category_form_page.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

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

  void submitForm(CookieRequest request) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.isEdit && widget.category != null) {
        // Update Category using POST (since pbp_django_auth lacks PUT)
        final response = await request.postJson(
          "http://127.0.0.1:8000/category/categories/update/${widget.category!.id}/",
          jsonEncode({'nama_category': _categoryName}),
        );

        if (response['success']) {
          showSnackBarMessage(response['message']);
          Navigator.pop(context);
        } else {
          showSnackBarMessage(response['message'] ?? "Error updating category", color: Colors.red);
        }
      } else {
        // Create Category
        final response = await request.postJson(
          "http://127.0.0.1:8000/category/categories/create/",
          jsonEncode({'nama_category': _categoryName}),
        );

        if (response['success']) {
          showSnackBarMessage(response['message']);
          Navigator.pop(context);
        } else {
          showSnackBarMessage(response['message'] ?? "Error creating category", color: Colors.red);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Category' : 'Add Category'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _categoryName,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
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
              ElevatedButton(
                onPressed: () => submitForm(request),
                child: Text(widget.isEdit ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
