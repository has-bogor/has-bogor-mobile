import 'package:flutter/material.dart';
import '../models/katalog_model.dart';
import '../services/api_service.dart';

class KatalogScreen extends StatefulWidget {
  const KatalogScreen({super.key});

  @override
  _KatalogScreenState createState() => _KatalogScreenState();
}

class _KatalogScreenState extends State<KatalogScreen> {
  final ApiService apiService = ApiService();
  List<Katalog> katalogItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchKatalogItems(); // Fetch data when screen initializes
  }

  Future<void> fetchKatalogItems() async {
    try {
      final items = await apiService.fetchKatalogItems();
      setState(() {
        katalogItems = items;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Katalog Items")),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader while fetching data
          : katalogItems.isEmpty
              ? Center(child: Text("No items available."))
              : ListView.builder(
                  itemCount: katalogItems.length,
                  itemBuilder: (context, index) {
                    final item = katalogItems[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(item.nama),
                        subtitle: Text("Rp ${item.harga.toStringAsFixed(0)} - ${item.toko}"),
                        onTap: () {
                          // Handle item tap
                        },
                      ),
                    );
                  },
                ),
    );
  }
}