// lib/screens/category_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import '../models/category.dart';
import 'category_form_page.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future<List<Category>> fetchCategories(CookieRequest request, {String order = 'asc', String search = ''}) async {
    String url = 'http://127.0.0.1:8000/category/categories/?order=$order&search=$search';
    final response = await request.get(url);

    List<Category> categories = [];
    if (response['success']) {
      for (var item in response['categories']) {
        categories.add(Category.fromJson(item));
      }
    }
    return categories;
  }

  void showSnackBarMessage(String message, {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Categories'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {}); // Refresh the list
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryFormPage(isEdit: false)),
              ).then((_) => setState(() {})); // Refresh after adding
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchCategories(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            // Error state
            return Center(child: Text('Error fetching categories'));
          } else {
            List<Category> categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                Category category = categories[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(category.namaCategory),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryFormPage(
                              isEdit: true,
                              category: category,
                            ),
                          ),
                        ).then((_) => setState(() {})); // Refresh after editing
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
