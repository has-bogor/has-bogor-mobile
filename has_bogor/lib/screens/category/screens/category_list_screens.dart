import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import '../models/category.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  TextEditingController _searchController = TextEditingController();
  String _order = 'asc';

  @override
  void initState() {
    super.initState();
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    categoryProvider.fetchCategories(order: _order);
  }

  void _showAddCategoryDialog() {
    TextEditingController _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Add Category'),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Category Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String name = _nameController.text.trim();
              if (name.isNotEmpty) {
                Provider.of<CategoryProvider>(context, listen: false).addCategory(name);
                Navigator.of(ctx).pop();
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditCategoryDialog(Category category) {
    TextEditingController _nameController = TextEditingController(text: category.namaCategory);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit Category'),
        content: TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Category Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              String newName = _nameController.text.trim();
              if (newName.isNotEmpty && newName != category.namaCategory) {
                Provider.of<CategoryProvider>(context, listen: false).updateCategory(category.id, newName);
                Navigator.of(ctx).pop();
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteCategory(Category category) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Category'),
        content: Text('Are you sure you want to delete "${category.namaCategory}"?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<CategoryProvider>(context, listen: false).deleteCategory(category.id);
              Navigator.of(ctx).pop();
            },
            child: Text('Delete'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  void _sortCategories(String order) {
    setState(() {
      _order = order;
    });
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories(order: _order, search: _searchController.text.trim());
  }

  void _searchCategories(String query) {
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories(order: _order, search: query.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddCategoryDialog,
          ),
        ],
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Categories',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  ),
                  onChanged: _searchCategories,
                ),
              ),

              // Sorting Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _sortCategories('asc'),
                      child: Text('Sort Ascending'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _order == 'asc' ? Colors.blue : Colors.grey,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _sortCategories('desc'),
                      child: Text('Sort Descending'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _order == 'desc' ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // Category List
              provider.isLoading
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : provider.errorMessage.isNotEmpty
                      ? Expanded(child: Center(child: Text(provider.errorMessage)))
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: () => provider.fetchCategories(order: _order, search: _searchController.text.trim()),
                            child: ListView.builder(
                              itemCount: provider.categories.length,
                              itemBuilder: (ctx, index) {
                                Category category = provider.categories[index];
                                return ListTile(
                                  title: Text(category.namaCategory),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit, color: Colors.blue),
                                        onPressed: () => _showEditCategoryDialog(category),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _confirmDeleteCategory(category),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
            ],
          );
        },
      ),
    );
  }
}
