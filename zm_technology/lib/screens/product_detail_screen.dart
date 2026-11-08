import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../services/contact_service.dart';

/// La ficha consulta SIEMPRE el endpoint individual usando el handle del catálogo.
/// El Future se crea una sola vez para evitar repetir la petición en cada rebuild.
class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Map<String, dynamic>> _detailFuture;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  void _loadDetail() {
    _detailFuture = ApiService().fetchProductDetail(widget.product.handle);
  }

  void _retry() {
    setState(_loadDetail);
  }

  Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return <String, dynamic>{};
  }

  String _string(dynamic value, [String fallback = '']) {
    if (value == null) return fallback;
    if (value is String) return value;
    return value.toString();
  }

  List<String> _imageUrls(Map<String, dynamic> data) {
    final result = <String>[];
    final rawImages = data['images'] ?? data['imagenes'];
    if (rawImages is List) {
      for (final item in rawImages) {
        if (item is String && item.trim().isNotEmpty) {
          result.add(item);
        } else if (item is Map) {
          final map = _asMap(item);
          final url = _string(map['url'] ?? map['src'] ?? map['image']);
          if (url.isNotEmpty) result.add(url);
        }
      }
    }
    final mainImage = _string(data['image'] ?? data['imagen']);
    if (mainImage.isNotEmpty && !result.contains(mainImage)) {
      result.insert(0, mainImage);
    }
    if (result.isEmpty && widget.product.image.isNotEmpty) {
      result.add(widget.product.image);
    }
    return result;
  }

  List<ProductVariant> _variants(Map<String, dynamic> data) {
    final raw = data['variants'] ?? data['variantes'];
    if (raw is List) {
      return raw.whereType<Map>().map((v) =>
        ProductVariant.fromJson(Map<String, dynamic>.from(v))).toList();
    }
    return widget.product.variants;
  }

  List<Widget> _optionWidgets(dynamic raw, BuildContext context) {
    if (raw is! List || raw.isEmpty) return [];
    return raw.whereType<Map>().map((item) {
      final option = _asMap(item);
      final name = _string(option['name'] ?? option['nombre'], 'Opción');
      final values = option['values'] ?? option['valores'];
      final valueText = values is List
          ? values.map((v) => _string(v)).join(', ')
          : _string(values);
      return ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(valueText.isEmpty ? 'Sin valores informados' : valueText),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, foregroundColor: const Color(0xFF101B35),
        elevation: 0, title: const Text('Ficha del producto', style: TextStyle(fontWeight: FontWeight.w700))),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                CircularProgressIndicator(),
                SizedBox(height: 12),
                Text('Consultando ficha en ZM TECHNOLOGY...'),
              ]),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.cloud_off, size: 54, color: Colors.redAccent),
                  const SizedBox(height: 12),
                  const Text('No se pudo consultar el detalle',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('${snapshot.error}', textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Volver a consultar'),
                  ),
                ]),
              ),
            );
          }

          final data = snapshot.data ?? <String, dynamic>{};
          final title = _string(data['title'] ?? data['titulo'], widget.product.title);
          final brand = _string(data['brand'] ?? data['marca'], widget.product.brand);
          final category = _string(data['category'] ?? data['categoria'], widget.product.category);
          final description = _string(data['description'] ?? data['descripcion']);
          final images = _imageUrls(data);
          final variants = _variants(data);
          final tagsRaw = data['tags'] ?? data['etiquetas'];
          final tags = tagsRaw is List ? tagsRaw.map((e) => _string(e)).toList() : <String>[];
          final options = data['options'] ?? data['opciones'];
          final detailPrice = data['minPrice'] ?? data['precioMinimo'];
          final minVariantPrice = variants
              .where((v) => v.price > 0)
              .map((v) => v.price)
              .fold<double?>(null, (a, b) => a == null || b < a ? b : a);
          final price = detailPrice is num
              ? detailPrice.toDouble()
              : double.tryParse('$detailPrice') ??
                  minVariantPrice ?? widget.product.minPrice;
          final sku = _string(data['sku'] ?? data['codigo']);

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
            children: [
              if (images.isNotEmpty)
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Container(
                            color: const Color(0xFFE9EDF5),
                            child: const Icon(Icons.image_not_supported, size: 56),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              )),
              const SizedBox(height: 4),
              Text('$brand · $category',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54)),
              const SizedBox(height: 12),
              Text('Desde: \$${price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                )),
              if (description.isNotEmpty) ...[
                const SizedBox(height: 18),
                const Text('Descripción', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                Text(description),
              ],
              if (sku.isNotEmpty) ...[
                const SizedBox(height: 12),
                _InfoRow(label: 'Código / SKU', value: sku),
              ],
              if (tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text('Etiquetas', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Wrap(spacing: 6, runSpacing: 4, children: tags.map((tag) =>
                  Chip(label: Text(tag), visualDensity: VisualDensity.compact)).toList()),
              ],
              if (options is List && options.isNotEmpty) ...[
                const Divider(height: 28),
                const Text('Opciones del producto',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ..._optionWidgets(options, context),
              ],
              if (variants.isNotEmpty) ...[
                const Divider(height: 28),
                const Text('Variantes y disponibilidad',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ...variants.map((variant) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(variant.title),
                  subtitle: Text([
                    if (variant.sku.isNotEmpty) 'SKU: ${variant.sku}',
                    if (variant.price > 0) 'Precio: \$${variant.price.toStringAsFixed(2)}',
                  ].join(' · ')),
                  trailing: Text(
                    variant.available ? 'Disponible' : 'Agotado',
                    style: TextStyle(
                      color: variant.available ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )),
              ],
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: () => ContactService.openWhatsApp(
                  message: 'Hola ZM TECHNOLOGY, deseo cotizar $title. ¿Me confirman precio y disponibilidad?',
                ),
                icon: const Icon(Icons.chat),
                label: const Text('Cotizar por WhatsApp'),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF128C7E),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Información consultada desde zmtechnology.store',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(width: 105, child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
      Expanded(child: Text(value)),
    ]),
  );
}
