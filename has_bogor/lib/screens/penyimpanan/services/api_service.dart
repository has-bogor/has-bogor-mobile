import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/katalog_model.dart';

class ApiService {
  // Localhost base URL
  final String baseUrl = "http://127.0.0.1:8000/penyimpanan";

  // Fetch all items
  Future<List<Katalog>> fetchKatalogItems() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/api/katalog/"));

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Katalog.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load items: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
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
    print(item);
    print(item.nama);
    print(item.harga);
    print(item.kategori);
    print(item.deskripsi);
    print(item.toko);
    final response = await http.post(
      Uri.parse("$baseUrl/api/add/"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "nama": item.nama,
        "harga": item.harga,
        "kategori": item.kategori,
        "deskripsi": item.deskripsi,
        "toko": item.toko,
      }),
    );

    if (response.statusCode != 201) { // Django redirects after successful POST
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