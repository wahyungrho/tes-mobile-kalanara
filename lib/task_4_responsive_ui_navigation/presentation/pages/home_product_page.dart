import 'package:flutter/material.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/data/datasource.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/domain/models/category_model.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/domain/models/product_model.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/presentation/pages/detail_page.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/presentation/widgets/chip_category_widget.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/presentation/widgets/product_card_widget.dart';

class HomeProductPage extends StatefulWidget {
  const HomeProductPage({super.key});

  @override
  State<HomeProductPage> createState() => _HomeProductPageState();
}

class _HomeProductPageState extends State<HomeProductPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar layar
    double screenWidth = MediaQuery.of(context).size.width;
    double childAspectRatio = 0.9;

    int crossAxisCount = 2;
    if (screenWidth >= 600) {
      crossAxisCount = 3;
      childAspectRatio = 1.0;
    }
    if (screenWidth >= 900) {
      crossAxisCount = 4;
      childAspectRatio = 1.1;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Home Product')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var banner in Datasource.banners) ...[
                    Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ), // Margin antar banner
                      width:
                          MediaQuery.of(context).size.width -
                          16, // Lebar berdasarkan ukuran layar
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(banner.imageUrl!),
                          fit:
                              BoxFit
                                  .cover, // Pastikan gambar menutupi seluruh container
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              banner.title!,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              banner.description!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: Datasource.categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        CategoryModel category = Datasource.categories[index];
                        return ChipCategoryWidget(
                          category: category,
                          isSelected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Products',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: childAspectRatio,
                    shrinkWrap: true, // ini penting
                    physics:
                        const NeverScrollableScrollPhysics(), // biar gak nested scroll
                    children:
                        Datasource.products
                            .map<Widget>(
                              (ProductModel e) => Hero(
                                tag: 'product-${e.id}',
                                child: ProductCardWidget(
                                  productModel: e,
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (_) =>
                                                ProductDetailPage(product: e),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
