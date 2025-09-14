import 'package:fashionapp/common/utils/app_routes.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/common/widgets/shimmers/categories_shimmer.dart';
import 'package:fashionapp/src/category/controller/category_notifier.dart';
import 'package:fashionapp/src/hook/fetch_categories.dart';
import 'package:fashionapp/src/hook/fetch_home_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoriesList extends HookWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchHomeCategories();
    final categories = result.categories;
    final isLoading = result.isLoading;
    final error = result.error;
    if (isLoading) {
      return const CatergoriesShimmer();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SizedBox(
        height: 80.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            categories.length,
            (i) {
              final category = categories[i];
              return GestureDetector(
                onTap: () {
                  context
                      .read<CategoryNotifier>()
                      .setCategory(category.title, category.id);
                  context.push('/category');
                },
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Kolors.kSecondaryLight,
                        child: Padding(
                          padding: EdgeInsets.all(4.h),
                          child: SvgPicture.network(
                            category.imageUrl,
                            width: 40.w,
                            height: 40.h,
                          ),
                        ),
                      ),
                      ReusableText(
                        text: category.title,
                        style: appStyle(12, Kolors.kGray, FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
