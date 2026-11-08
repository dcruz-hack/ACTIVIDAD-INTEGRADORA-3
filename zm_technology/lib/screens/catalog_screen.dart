import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../providers/product_provider.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});
  @override State<CatalogScreen> createState() => _CatalogScreenState();
}
class _CatalogScreenState extends State<CatalogScreen> {
  String query = '', selectedCategory = 'Todos';
  bool requested = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!requested) {
      requested = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.read<ProductProvider>().loadProducts();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final p = context.watch<ProductProvider>();
    final categories = <String>{'Todos', ...p.products.map((e) => e.category).where((e) => e.isNotEmpty)}.toList();
    final items = p.products.where((e) {
      final matchCategory = selectedCategory == 'Todos' || e.category == selectedCategory;
      return matchCategory && '${e.title} ${e.brand} ${e.category} ${e.sku}'.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(15,13,15,8), child: TextField(
        onChanged: (v) => setState(() => query = v),
        decoration: const InputDecoration(hintText: 'Buscar en ZM TECHNOLOGY', prefixIcon: Icon(Icons.search, color: zmNavy),
          suffixIcon: Icon(Icons.tune, color: zmNavy)))),
      if (p.products.isNotEmpty) SizedBox(height: 46, child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 14), scrollDirection: Axis.horizontal,
        children: categories.map((c) => Padding(padding: const EdgeInsets.only(right: 7), child: ChoiceChip(
          label: Text(c), selected: selectedCategory == c, onSelected: (_) => setState(() => selectedCategory = c),
          selectedColor: const Color(0xFFE5F4FC), side: BorderSide(color: selectedCategory == c ? zmBlue : const Color(0xFFE0E5EC)),
          labelStyle: TextStyle(color: selectedCategory == c ? zmBlue : zmNavy, fontWeight: FontWeight.w600, fontSize: 11),
        ))).toList())),
      Expanded(child: switch (p.status) {
        ProductStatus.loading => const Center(child: CircularProgressIndicator()),
        ProductStatus.error => Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(
          mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.cloud_off_outlined, size: 48, color: zmRed),
            Text(p.errorMessage ?? 'No se pudo cargar el catálogo.', textAlign: TextAlign.center),
            const SizedBox(height: 14), FilledButton(onPressed: () => context.read<ProductProvider>().loadProducts(), child: const Text('Reintentar'))]))),
        ProductStatus.success => RefreshIndicator(onRefresh: () => context.read<ProductProvider>().loadProducts(),
          child: filteredGrid(items)),
      }),
    ]);
  }

  Widget filteredGrid(List<Product> items) => items.isEmpty
    ? ListView(physics: const AlwaysScrollableScrollPhysics(), children: const [SizedBox(height: 100), Center(child: Text('No se encontraron productos.'))])
    : GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(), padding: const EdgeInsets.fromLTRB(13,12,13,22),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: .67),
      itemCount: items.length,
      itemBuilder: (context,i) {
        final product = items[i];
        return ProductCard(product: product, onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product))));
      });
}
