import 'package:flutter/material.dart';
import 'package:flutter_tes_mobile_kalanara_group/task_4_responsive_ui_navigation/domain/models/category_model.dart';

class ChipCategoryWidget extends StatelessWidget {
  final CategoryModel? category;
  final bool? isSelected;
  final Function()? onTap;
  const ChipCategoryWidget({
    super.key,
    this.category,
    this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected! ? Colors.orange : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            category?.name ?? '',
            style: TextStyle(
              color: isSelected! ? Colors.white : Colors.black87,
              fontWeight: isSelected! ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
