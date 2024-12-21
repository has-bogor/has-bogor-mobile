import 'package:flutter/material.dart';
import '../models/katalog_model.dart';
import '../services/api_service.dart';
import 'item_form_screen.dart';

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

  Future<void> addItem() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ItemFormScreen()),
    );
    if (result == true) fetchKatalogItems();
  }

  Future<void> editItem(Katalog item) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ItemFormScreen(item: item)),
  );
  if (result == true) fetchKatalogItems();
}

  Future<void> deleteItem(int id) async {
    try {
      await apiService.deleteItem(id);
      fetchKatalogItems();
    } catch (e) {
      print("Error deleting item: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Katalog Item"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: addItem, // Trigger adding a new item
          ),
        ],
      ),
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
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rp ${item.harga.toStringAsFixed(0)}"),
                            Text(item.toko),
                            Text(item.deskripsi), // Add more information as needed
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => editItem(item), // Trigger editing the item
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text("Delete Item"),
                                  content: Text("Are you sure you want to delete this item?"),
                                  actions: [
                                    TextButton(
                                      child: Text("Cancel"),
                                      onPressed: () => Navigator.of(ctx).pop(),
                                    ),
                                    TextButton(
                                      child: Text("Delete"),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        deleteItem(item.id); // Trigger deleting the item
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
