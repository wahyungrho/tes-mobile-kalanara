import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tes_mobile_kalanara_group/extension.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/domain/models/product_model.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel? productModel;
  final Function? onTap;
  const ProductCardWidget({super.key, this.productModel, this.onTap});

  bool isNetworkImage(String path) {
    return path.startsWith('http');
  }

  bool isAssetImage(String path) {
    return !path.contains('/') && !path.startsWith('http');
  }

  Widget buildImage(String? path) {
    if (path == null || path.isEmpty) {
      return const Icon(
        Icons.image_not_supported,
        size: 100,
        color: Colors.grey,
      );
    }

    if (isNetworkImage(path)) {
      return Image.network(
        path,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (isAssetImage(path)) {
      return Image.asset(
        path,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(path),
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = (productModel?.stock ?? 0) == 0;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(productModel?.image),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel?.name ?? '-',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (productModel?.price ?? 0).currencyFormatRp,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        isOutOfStock
                            ? 'Out of Stock'
                            : 'Stock : ${productModel?.stock}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isOutOfStock ? Colors.grey : Colors.black54,
                        ),
                      ),
                    ],
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
