import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product_model.dart';
import 'product_detail_screen.dart';

class ApiProductsScreen extends StatefulWidget {
  const ApiProductsScreen({super.key});
  @override State<ApiProductsScreen> createState() => _ApiProductsScreenState();
}
class _ApiProductsScreenState extends State<ApiProductsScreen> {
  String search = '';
  String category = 'Todas';
  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<ProductProvider>().loadProducts();
    });
  }
  @override Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final categoryValues = provider.products.map((p) => p.category).where((c) => c.isNotEmpty).toSet().toList()..sort();
    final categories = ['Todas', ...categoryValues];
    final filtered = provider.products.where((p) =>
      (category == 'Todas' || p.category == category) &&
      '${p.title} ${p.brand} ${p.category} ${p.sku}'.toLowerCase().contains(search.toLowerCase())).toList();
    return Column(children: [
      Padding(padding: const EdgeInsets.fromLTRB(12,12,12,6), child: TextField(
        onChanged: (v) => setState(() => search = v),
        decoration: InputDecoration(hintText: 'Buscar en ZM TECHNOLOGY', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none)),
      )),
      if (provider.status == ProductStatus.success) SizedBox(height: 44, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 10), children: categories.map((c) => Padding(padding: const EdgeInsets.only(right: 6), child: ChoiceChip(label: Text(c), selected: category == c, onSelected: (_) => setState(() => category = c)))).toList())),
      Expanded(child: switch (provider.status) {
        ProductStatus.loading => const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [CircularProgressIndicator(), SizedBox(height:12), Text('Cargando productos de ZM TECHNOLOGY...')])),
        ProductStatus.error => Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.cloud_off, size: 54, color: Colors.redAccent), const SizedBox(height: 8), const Text('No se pudo conectar con la tienda', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(provider.errorMessage ?? 'Error de conexión', textAlign: TextAlign.center), const SizedBox(height: 12),
          FilledButton.icon(onPressed: () => context.read<ProductProvider>().loadProducts(), icon: const Icon(Icons.refresh), label: const Text('Reintentar')),
          TextButton(onPressed: () => context.read<ProductProvider>().loadProducts(simulateError: true), child: const Text('Probar error QA')),
        ]))),
        ProductStatus.success => RefreshIndicator(onRefresh: () => context.read<ProductProvider>().loadProducts(), child: ListView(physics: const AlwaysScrollableScrollPhysics(), padding: const EdgeInsets.all(12), children: [
          Row(children: [const Icon(Icons.cloud_done, color: Colors.green), const SizedBox(width:8), Expanded(child: Text('${filtered.length} productos · ${provider.products.length} en catálogo', style: const TextStyle(fontWeight: FontWeight.bold))), IconButton(onPressed: () => context.read<ProductProvider>().loadProducts(), icon: const Icon(Icons.refresh))]),
          ...filtered.map((p) => _productCard(context, p)),
          if (filtered.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Center(child: Text('No se encontraron productos.'))),
          const Center(child: Text('Desliza hacia abajo para actualizar', style: TextStyle(fontSize: 11, color: Colors.grey))),
        ])),
      }),
    ]);
  }
  Widget _productCard(BuildContext context, Product p) => Card(margin: const EdgeInsets.only(bottom: 10), clipBehavior: Clip.antiAlias, child: InkWell(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p))),
    child: Row(children: [
      SizedBox(width: 112, height: 118, child: p.image.isEmpty ? const Icon(Icons.computer, size: 42) : Image.network(p.image, fit: BoxFit.contain, errorBuilder: (_,__,___) => const Icon(Icons.image_not_supported, size: 40))),
      Expanded(child: Padding(padding: const EdgeInsets.all(11), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(p.category.toUpperCase(), style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
        Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
        if (p.brand.isNotEmpty) Text(p.brand, style: const TextStyle(fontSize: 11, color: Colors.black54)),
        Text('\$${p.minPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.primary)),
        Text(p.available ? 'Disponible' : 'Consultar disponibilidad', style: TextStyle(fontSize: 10, color: p.available ? Colors.green : Colors.orange)),
        const Text('Ver ficha completa  ›', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ]))),
    ]),
  ));
}
