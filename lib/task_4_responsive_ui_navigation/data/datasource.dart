import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/domain/models/banner_model.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/domain/models/category_model.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/domain/models/product_model.dart';

class Datasource {
  static List<BannerModel> banners = [
    BannerModel(
      id: '1',
      imageUrl: 'https://picsum.photos/5000/3333',
      title: 'Welcome to Kalanara Group',
      description: 'Your journey starts here.',
    ),
    BannerModel(
      id: '2',
      imageUrl: 'https://picsum.photos/5000/3333',
      title: 'Explore Our Services',
      description: 'Discover what we have to offer.',
    ),
  ];

  static List<CategoryModel> categories = [
    CategoryModel(id: 1, name: 'Cat 1', description: 'Description 1'),
    CategoryModel(id: 2, name: 'Cat 2', description: 'Description 2'),
    CategoryModel(id: 3, name: 'Cat 3', description: 'Description 3'),
    CategoryModel(id: 4, name: 'Cat 4', description: 'Description 4'),
    CategoryModel(id: 5, name: 'Cat 5', description: 'Description 5'),
  ];

  static List<ProductModel> products = List.generate(
    16,
    (index) => ProductModel(
      id: index + 1,
      categoryId: (index % 5) + 1,
      name: 'Product ${index + 1}',
      description: 'Description ${index + 1}',
      price: (index + 1) * 10000.0,
      stock: (index + 1) * 5,
      image: 'https://picsum.photos/5000/3333',
      isActive: 1,
    ),
  );
}
