import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProductDetailView extends StatefulWidget {
  final String title, brand, category, description;
  final double price, discount, rating;
  final int stock;
  final List<String> images;

  const ProductDetailView({
    super.key,
    required this.title,
    required this.brand,
    required this.category,
    required this.description,
    required this.price,
    required this.discount,
    required this.rating,
    required this.stock,
    required this.images,
  });

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int _page = 0;

  Widget _chip(String text, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
        child: Text(text,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.text)),
      );

  @override
  Widget build(BuildContext context) {
    final finalPrice = widget.price * (1 - widget.discount / 100);
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Galeri gambar
            Container(
              height: 380,
              decoration: const BoxDecoration(
                color: AppColors.lavender,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: widget.images.length,
                      onPageChanged: (i) => setState(() => _page = i),
                      itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.fromLTRB(40, 56, 40, 40),
                        child: Image.network(widget.images[i], fit: BoxFit.contain),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 12,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_rounded,
                              color: AppColors.text),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 14,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.images.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: i == _page ? 22 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: i == _page ? Colors.white : Colors.white54,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.brand.toUpperCase(),
                      style: const TextStyle(
                          letterSpacing: 2, fontSize: 12, color: AppColors.subtext)),
                  const SizedBox(height: 6),
                  Text(widget.title,
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text)),
                  const SizedBox(height: 14),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    _chip('⭐ ${widget.rating.toStringAsFixed(1)}', AppColors.butter),
                    _chip(widget.category, AppColors.mint),
                    _chip('Stok ${widget.stock}', AppColors.sky),
                  ]),
                  const SizedBox(height: 22),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('\$${finalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: AppColors.text)),
                      const SizedBox(width: 10),
                      Text('\$${widget.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.subtext)),
                      const SizedBox(width: 10),
                      _chip('-${widget.discount.toStringAsFixed(0)}%', AppColors.pink),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text('Deskripsi',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.text)),
                  const SizedBox(height: 8),
                  Text(widget.description,
                      style: const TextStyle(
                          height: 1.6, color: AppColors.subtext)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}