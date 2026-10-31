import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'search_field.dart';

class HomeLayout extends StatelessWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClear;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onRetry;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const HomeLayout({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onClear,
    required this.isLoading,
    required this.errorMessage,
    required this.onRetry,
    required this.itemCount,
    required this.itemBuilder,
  });

  Widget _body() {
    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(color: AppColors.lavender));
    }
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_rounded,
                size: 56, color: AppColors.subtext),
            const SizedBox(height: 12),
            Text(errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.subtext)),
            const SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: AppColors.lavender,
                  foregroundColor: AppColors.text),
              onPressed: onRetry,
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      );
    }
    if (itemCount == 0) {
      return const Center(
        child: Text('Produk tidak ditemukan',
            style: TextStyle(color: AppColors.subtext)),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Temukan Produk',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: SearchField(
                controller: searchController,
                onChanged: onSearchChanged,
                onClear: onClear,
              ),
            ),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }
}