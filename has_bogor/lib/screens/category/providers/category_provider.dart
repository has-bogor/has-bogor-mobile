import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/api_service.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  final ApiService _apiService = ApiService();

  Future<void> fetchCategories({String order = 'asc', String search = ''}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _categories = await _apiService.fetchCategories(order: order, search: search);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString();
      _categories = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addCategory(String namaCategory) async {
    // Assuming CSRF is not required or handled
    try {
      Category newCategory = await _apiService.createCategory(namaCategory, '');
      _categories.add(newCategory);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateCategory(int id, String namaCategory) async {
    try {
      Category updatedCategory = await _apiService.updateCategory(id, namaCategory, '');
      int index = _categories.indexWhere((cat) => cat.id == id);
      if (index != -1) {
        _categories[index] = updatedCategory;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      await _apiService.deleteCategory(id, '');
      _categories.removeWhere((cat) => cat.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
