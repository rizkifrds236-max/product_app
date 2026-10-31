import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_detail_view.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ProductDetailView(
      title: product.title,
      brand: product.brand,
      category: product.category,
      description: product.description,
      price: product.price,
      discount: product.discountPercentage,
      rating: product.rating,
      stock: product.stock,
      images: product.images,
    );
  }
}
