import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:fashionapp/src/home/controller/home_tab_notifier.dart';
import 'package:fashionapp/src/product/widgets/stagred_title_widget.dart';
import 'package:fashionapp/src/products/hooks/fetch_products.dart';
import 'package:fashionapp/src/wishlist/controller/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ExploreProduct extends HookWidget {
  const ExploreProduct({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final result = fetchProducts(context.read<HomeTabNotifier>().queryType);
    final products = result.products;
    final isLoading = result.isLoading;
    final error = result.error;

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: ListShimmer(),
      );
    }
    return products.isEmpty
        ? Padding(
            padding: EdgeInsets.all(25.w),
            child: Image.asset(
              R.ASSETS_IMAGES_EMPTY_PNG,
              height: ScreenUtil().screenHeight * .3,
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: List.generate(
                products.length,
                (index) {
                  final double mainAxisCellCount = (index % 2 == 0 ? 4.2 : 2.7);

                  return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: mainAxisCellCount,
                    child: StagredTitleWidget(
                      product: products[index],
                      i: index,
                      onTab: () {
                        if (accessToken == null) {
                          loginBottomSheet(context);
                        } else {
                          context
                              .read<WishlistNotifier>()
                              .addRemoveWishlist(products[index].id, () {});
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          );
  }
}
