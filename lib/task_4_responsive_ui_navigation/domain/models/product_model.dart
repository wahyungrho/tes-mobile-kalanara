class ProductModel {
  final int? id;
  final int? categoryId;
  final String? name;
  final String? description;
  final double? price;
  final int? stock;
  final String? image;
  final int? isActive;

  ProductModel({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.image,
    this.isActive,
  });
}
