import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:has_bogor/widgets/left_drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import 'category_form_page.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Define the GlobalKey for controlling the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  Future<void> deleteCategory(CookieRequest request, int categoryId) async {
    String url = 'http://127.0.0.1:8000/category/categories/delete/$categoryId/'; // Correct URL format

    // Use http.delete to send the DELETE request
    final response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': request.cookies.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        showSnackBarMessage('Category deleted successfully');
        setState(() {}); // Refresh the list
      } else {
        showSnackBarMessage('Failed to delete category', color: Colors.red);
      }
    } else {
      showSnackBarMessage('Error: ${response.statusCode}', color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      key: _scaffoldKey, // Associate the scaffoldKey with the Scaffold widget
      backgroundColor: Colors.transparent, // Transparent background to enable gradient
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1D1E3C), Color(0xff004F8C)],  // Gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Transparent AppBar
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer(); // Open the drawer using scaffoldKey
              },
            ),
          ),
        ),
      ),
      drawer: const LeftDrawer(), // Add Left Drawer (custom widget)
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1D1E3C), Color(0xff004F8C)],  // Gradient background
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              Text(
                "Manage Categories",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Browse and manage your categories below.",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 20),

              // Refresh Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {}); // Refresh the list
                    },
                    child: Text("Refresh"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CategoryFormPage(isEdit: false)),
                      ).then((_) => setState(() {})); // Refresh after adding
                    },
                    child: Text("Add New Category"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Categories List
              FutureBuilder(
                future: fetchCategories(request),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return Center(child: Text('Error fetching categories', style: TextStyle(color: Colors.white)));
                  } else {
                    List<Category> categories = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true, // Prevent overflow
                      physics: NeverScrollableScrollPhysics(), // Disable scroll in the list view to allow the SingleChildScrollView to handle scrolling
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        Category category = categories[index];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          color: Colors.black,
                          child: ListTile(
                            title: Text(category.namaCategory),
                            subtitle: Text("ID: ${category.id}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
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
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // Confirm deletion before actually deleting
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Delete Category'),
                                          content: Text('Are you sure you want to delete this category?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                              child: Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                deleteCategory(request, category.id);
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                              child: Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
