import 'package:flutter/material.dart';
import '../main.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product; final VoidCallback? onTap;
  const ProductCard({super.key, required this.product, this.onTap});
  @override Widget build(BuildContext context) => Material(
    color: Colors.white, borderRadius: BorderRadius.circular(10),
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(10),
      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E9EF))), clipBehavior: Clip.antiAlias,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Stack(children: [
            Positioned.fill(child: product.image.isEmpty
              ? const ColoredBox(color: Color(0xFFF4F6F8), child: Icon(Icons.image_outlined, size: 42, color: Colors.black26))
              : Image.network(product.image, fit: BoxFit.contain,
                  errorBuilder: (_,__,___) => const ColoredBox(color: Color(0xFFF4F6F8), child: Icon(Icons.image_not_supported_outlined, size: 40)))),
            Positioned(left: 8, top: 8, child: Container(padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFFE5F4FC), borderRadius: BorderRadius.circular(4)),
              child: Text(product.category, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: zmBlue, fontSize: 9, fontWeight: FontWeight.w700)))),
          ])),
          Padding(padding: const EdgeInsets.fromLTRB(10,8,10,10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (product.brand.isNotEmpty) Text(product.brand.toUpperCase(),
              style: const TextStyle(color: Color(0xFF8290A1), fontSize: 9, letterSpacing: .5, fontWeight: FontWeight.w700)),
            const SizedBox(height: 3),
            Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: zmNavy, fontSize: 12, height: 1.2, fontWeight: FontWeight.w700)),
            const SizedBox(height: 7),
            Text('Desde \$${product.minPrice.toStringAsFixed(2)}',
              style: const TextStyle(color: zmNavy, fontSize: 15, fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            SizedBox(width: double.infinity, height: 32, child: FilledButton(onPressed: onTap,
              style: FilledButton.styleFrom(backgroundColor: zmRed, foregroundColor: Colors.white, padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
              child: const Text('VER PRODUCTO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800)))),
          ])),
        ]))));
}
