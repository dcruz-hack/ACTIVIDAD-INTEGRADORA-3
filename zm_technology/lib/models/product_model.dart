class ProductVariant {
  final String id, title, sku;
  final double price;
  final double? compareAtPrice;
  final bool available;

  const ProductVariant({required this.id, required this.title, required this.sku,
    required this.price, this.compareAtPrice, required this.available});

  factory ProductVariant.fromJson(Map<String, dynamic> json) => ProductVariant(
    id: '${json['id'] ?? ''}',
    title: '${json['title'] ?? json['titulo'] ?? 'Presentación'}',
    sku: '${json['sku'] ?? ''}',
    price: _number(json['price'] ?? json['precio']),
    compareAtPrice: _nullableNumber(json['compareAtPrice'] ?? json['compararPrecio']),
    available: (json['available'] ?? json['disponible']) == true,
  );

  Map<String, dynamic> toJson() => {
    'id': id, 'title': title, 'sku': sku, 'price': price,
    'compareAtPrice': compareAtPrice, 'available': available,
  };
}

class Product {
  final String id, handle, title, brand, category, image;
  final double minPrice;
  final List<ProductVariant> variants;

  const Product({required this.id, required this.handle, required this.title,
    required this.brand, required this.category, required this.image,
    required this.minPrice, required this.variants});

  factory Product.fromJson(Map<String, dynamic> json) {
    final rawVariants = json['variants'] ?? json['variantes'];
    return Product(
      id: '${json['id'] ?? ''}',
      handle: '${json['handle'] ?? json['manejador'] ?? ''}',
      title: '${json['title'] ?? json['titulo'] ?? 'Producto'}',
      brand: '${json['brand'] ?? json['marca'] ?? ''}',
      category: '${json['category'] ?? json['categoria'] ?? 'Otros'}',
      image: '${json['image'] ?? json['imagen'] ?? ''}',
      minPrice: _number(json['minPrice'] ?? json['precioMinimo'] ?? json['precio mínimo']),
      variants: rawVariants is List
        ? rawVariants.whereType<Map>().map((v) => ProductVariant.fromJson(Map<String,dynamic>.from(v))).toList()
        : const [],
    );
  }

  bool get available => variants.any((v) => v.available);
  String get sku => variants.map((v) => v.sku).where((s) => s.isNotEmpty).join(', ');

  Map<String, dynamic> toJson() => {
    'id': id, 'handle': handle, 'title': title, 'brand': brand,
    'category': category, 'image': image, 'minPrice': minPrice,
    'variants': variants.map((v) => v.toJson()).toList(),
  };
}

double _number(dynamic value) => value is num ? value.toDouble() : double.tryParse('$value') ?? 0;
double? _nullableNumber(dynamic value) => value == null ? null : _number(value);
