import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
class ApiService {
 static const endpoint='https://dummyjson.com/products/category/laptops';
 Future<List<Product>> fetchProducts() async {
  final r=await http.get(Uri.parse(endpoint)).timeout(const Duration(seconds:20));
  if(r.statusCode!=200) throw Exception('El servidor respondió ${r.statusCode}.');
  final j=jsonDecode(utf8.decode(r.bodyBytes));
  if(j is! Map<String,dynamic> || j['products'] is! List) throw const FormatException('JSON no válido.');
  return (j['products'] as List).map((e)=>Product.fromJson(e as Map<String,dynamic>)).toList();
 }
}
