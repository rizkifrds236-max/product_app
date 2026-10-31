import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String category;
  final String thumbnail;
  final double price;
  final double rating;
  final Color color;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.category,
    required this.thumbnail,
    required this.price,
    required this.rating,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.6),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Hero(
                        tag: 'img_$thumbnail',
                        child: Image.network(
                          thumbnail,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.image_not_supported_outlined),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star_rounded, size: 14, color: Color(0xFFFFB84D)),
                            const SizedBox(width: 2),
                            Text(rating.toStringAsFixed(1),
                                style: const TextStyle(fontSize: 11, color: AppColors.text)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 10, letterSpacing: 1, color: AppColors.subtext)),
                  const SizedBox(height: 2),
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: AppColors.text)),
                  const SizedBox(height: 4),
                  Text('\$${price.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: AppColors.text)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}