class Product {
  final int id; final String title, description, thumbnail, category;
  final double price, rating;
  const Product({required this.id, required this.title, required this.description,
    required this.thumbnail, required this.category, required this.price, required this.rating});
  factory Product.fromJson(Map<String,dynamic> j) => Product(
    id:j['id'] as int? ?? 0, title:j['title'] as String? ?? 'Producto',
    description:j['description'] as String? ?? '', thumbnail:j['thumbnail'] as String? ?? '',
    category:j['category'] as String? ?? 'technology',
    price:(j['price'] as num? ?? 0).toDouble(), rating:(j['rating'] as num? ?? 0).toDouble());
  Map<String,dynamic> toJson()=>{'id':id,'title':title,'description':description,
    'thumbnail':thumbnail,'category':category,'price':price,'rating':rating};
}
