import 'package:corelab_app_challenge/src/core/ui/styles/colors_app.dart';
import 'package:corelab_app_challenge/src/core/ui/styles/text_styles.dart';
import 'package:corelab_app_challenge/src/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;
  const CategoryTile({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      color: Colors.white,
      child: Text(
        category.name,
        style: context.textStyles.textRegular
            .copyWith(color: ColorsApp.i.textSecondary, fontSize: 20),
        maxLines: 1,
      ),
    );
  }
}
