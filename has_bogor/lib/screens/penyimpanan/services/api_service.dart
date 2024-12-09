import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/katalog_model.dart';

class ApiService {
  // Localhost base URL
  final String baseUrl = "http://127.0.0.1:8000";

  // Fetch all items
  Future<List<Katalog>> fetchKatalogItems() async {
    final response = await http.get(Uri.parse("$baseUrl/api/katalog/"));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Katalog.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load items");
    }
  }

  // Fetch an item by ID
  Future<Katalog> fetchItemById(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/get_item/$id/"));

    if (response.statusCode == 200) {
      return Katalog.fromJson(json.decode(response.body)[0]); // Django returns a list for filters
    } else {
      throw Exception("Failed to load item");
    }
  }

  // Add a new item
  Future<void> addItem(Katalog item) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add_item/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode != 302) { // Django redirects after successful POST
      throw Exception("Failed to add item");
    }
  }

  // Update an item
  Future<void> updateItem(int id, Katalog item) async {
    final response = await http.post(
      Uri.parse("$baseUrl/items/$id/update/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(item.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update item");
    }
  }

  // Delete an item
  Future<void> deleteItem(int id) async {
    final response = await http.post(Uri.parse("$baseUrl/delete_item/$id/"));

    if (response.statusCode != 302) { // Django redirects after successful POST
      throw Exception("Failed to delete item");
    }
  }
}