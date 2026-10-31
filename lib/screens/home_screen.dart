import 'dart:async';

import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../theme/app_colors.dart';
import '../widgets/home_layout.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductService _productService = ProductService();
  final TextEditingController _searchController = TextEditingController();
  final List<Product> _products = [];
  Timer? _debounce;
  String? _errorMessage;
  String _currentQuery = '';
  bool _isLoading = true;
  int _requestId = 0;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts({String? query}) async {
    final requestId = ++_requestId;
    final searchQuery = query ?? _currentQuery;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final products = searchQuery.trim().isEmpty
          ? await _productService.fetchProducts()
          : await _productService.searchProducts(searchQuery);
      if (!mounted || requestId != _requestId) return;

      setState(() {
        _products
          ..clear()
          ..addAll(products);
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted || requestId != _requestId) return;

      setState(() {
        _errorMessage = 'Gagal memuat produk: $error';
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _currentQuery = query;
    ++_requestId;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _loadProducts(query: query);
    });
  }

  void _onClear() {
    _debounce?.cancel();
    _searchController.clear();
    _currentQuery = '';
    _loadProducts(query: '');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
      searchController: _searchController,
      onSearchChanged: _onSearchChanged,
      onClear: _onClear,
      isLoading: _isLoading,
      errorMessage: _errorMessage,
      onRetry: () => _loadProducts(query: _currentQuery),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return ProductCard(
          title: product.title,
          category: product.category,
          thumbnail: product.thumbnail,
          price: product.price,
          rating: product.rating,
          color: AppColors.cardColors[index % AppColors.cardColors.length],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => DetailScreen(product: product),
              ),
            );
          },
        );
      },
    );
  }
}
