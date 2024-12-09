import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class ApiService {
  static const String baseUrl = 'http://your-domain.com/category/';

  // Fetch categories
  Future<List<Category>> fetchCategories({String order = 'asc', String search = ''}) async {
    final response = await http.get(
      Uri.parse('${baseUrl}categories/?order=$order&search=$search'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        List<Category> categories = (data['categories'] as List)
            .map((categoryJson) => Category.fromJson(categoryJson))
            .toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } else {
      throw Exception('Failed to load categories');
    }
  }

  // Create a new category
  Future<Category> createCategory(String namaCategory, String csrfToken) async {
    final response = await http.post(
      Uri.parse('${baseUrl}categories/create/'),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRFToken': csrfToken, // If CSRF is required
      },
      body: json.encode({'nama_category': namaCategory}),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      if (data['success']) {
        return Category.fromJson(data['category']);
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to create category');
    }
  }

  // Update a category
  Future<Category> updateCategory(int id, String namaCategory, String csrfToken) async {
    final response = await http.put(
      Uri.parse('${baseUrl}categories/update/$id/'),
      headers: {
        'Content-Type': 'application/json',
        'X-CSRFToken': csrfToken, // If CSRF is required
      },
      body: json.encode({'nama_category': namaCategory}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        return Category.fromJson(data['category']);
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to update category');
    }
  }

  // Delete a category
  Future<void> deleteCategory(int id, String csrfToken) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}categories/delete/$id/'),
      headers: {
        'X-CSRFToken': csrfToken, // If CSRF is required
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (!data['success']) {
        throw Exception('Failed to delete category');
      }
    } else {
      throw Exception('Failed to delete category');
    }
  }
}
