import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
enum ProductStatus { loading, success, error }
class ProductProvider extends ChangeNotifier {
  final ApiService _api;
  ProductProvider({ApiService? api}) : _api = api ?? ApiService();
  ProductStatus _status = ProductStatus.loading;
  List<Product> _products = [];
  String? _error;
  ProductStatus get status => _status;
  List<Product> get products => List.unmodifiable(_products);
  String? get errorMessage => _error;

  Future<void> loadProducts({bool simulateError = false}) async {
    _status = ProductStatus.loading; _error = null; notifyListeners();
    try {
      if (simulateError) throw Exception('Error de conexión simulado para evidencia QA.');
      _products = await _api.fetchProducts();
      _status = ProductStatus.success;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _status = ProductStatus.error;
    }
    notifyListeners();
  }
}
