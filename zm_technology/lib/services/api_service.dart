import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://zmtechnology.store/api/public';
  static const String productsEndpoint = '$baseUrl/products';
  final http.Client _client;
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Product>> fetchProducts() async {
    final response = await _client.get(Uri.parse(productsEndpoint), headers: {'Accept': 'application/json'})
      .timeout(const Duration(seconds: 25));
    if (response.statusCode != 200) {
      throw Exception('La API de ZM TECHNOLOGY respondió HTTP ${response.statusCode}.');
    }
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    final dynamic rawList = decoded is List ? decoded
      : decoded is Map ? (decoded['productos'] ?? decoded['products'] ?? decoded['data']) : null;
    if (rawList is! List) {
      throw const FormatException('La respuesta de productos no contiene una lista reconocible.');
    }
    return rawList.whereType<Map>().map((item) => Product.fromJson(Map<String,dynamic>.from(item))).toList();
  }

  Future<Map<String, dynamic>> fetchProductDetail(String handle) async {
    if (handle.trim().isEmpty) throw ArgumentError('El producto no tiene handle.');
    final uri = Uri.parse('$productsEndpoint/${Uri.encodeComponent(handle)}');
    final response = await _client.get(uri, headers: {'Accept': 'application/json'})
      .timeout(const Duration(seconds: 25));
    if (response.statusCode != 200) {
      throw Exception('La ficha del producto respondió HTTP ${response.statusCode}.');
    }
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map<String, dynamic>) throw const FormatException('La ficha no tiene formato JSON de objeto.');
    final nested = decoded['producto'] ?? decoded['product'] ?? decoded['data'];
    return nested is Map ? Map<String,dynamic>.from(nested) : decoded;
  }
}
