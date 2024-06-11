import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductController extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;
  void fetchProducts(String apiUrl) async {
    print('api callingggg $apiUrl');
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> parsedData = json.decode(response.body);
      print('data $parsedData');
      _products = parsedData.map((item) => Product(title: item['item'], description: item['description'], image: item['image'], category: item['category'], price: item['price'])).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load products');
    }
  }
}