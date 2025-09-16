import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/category/controller/category_notifier.dart';
import 'package:fashionapp/src/category/widgets/product_by_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: context.read<CategoryNotifier>().category,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: ProductsByCategory(),
    );
  }
}
