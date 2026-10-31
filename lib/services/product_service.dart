import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$_baseUrl?limit=0'));
    return _decodeProductList(response);
  }

  Future<List<Product>> searchProducts(String query) async {
    final uri = Uri.parse('$_baseUrl/search')
        .replace(queryParameters: {'q': query});
    final response = await http.get(uri);
    return _decodeProductList(response);
  }

  Future<Product> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat detail produk (${response.statusCode})');
    }

    return Product.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  List<Product> _decodeProductList(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat produk (${response.statusCode})');
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final products = json['products'] as List<dynamic>;
    return products
        .map((product) => Product.fromJson(product as Map<String, dynamic>))
        .toList();
  }
}
