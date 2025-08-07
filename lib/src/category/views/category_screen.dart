import 'package:fashionapp/common/utils/app_routes.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/category/controller/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: 'Categories',
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            onTap: () {
              context
                  .read<CategoryNotifier>()
                  .setCategory(category.title, index);
              context.push('/category');
            },
            leading: CircleAvatar(
              backgroundColor: Kolors.kSecondaryLight,
              radius: 18,
              child: Padding(
                padding: EdgeInsets.all(8.h),
                child: SvgPicture.network(category.imageUrl),
              ),
            ),
            title: ReusableText(
              text: category.title,
              style: appStyle(12, Kolors.kGray, FontWeight.normal),
            ),
            trailing: Icon(
              MaterialCommunityIcons.chevron_double_right,
              size: 18,
            ),
          );
        },
      ),
    );
  }
}
