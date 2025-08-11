import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/main.dart';
import 'package:fashionapp/src/products/controller/products_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    print(context.read<ProductsNotifier>().product!.title);
    return Consumer<ProductsNotifier>(
        builder: (context, productnotifier, child) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 320.h,
              collapsedHeight: 65.h,
              floating: false,
              pinned: true,
              leading: const AppBackButton(),
              actions: [
                GestureDetector(
                  child: const CircleAvatar(
                    backgroundColor: Kolors.kSecondaryLight,
                    child: Icon(
                      AntDesign.heart,
                      color: Kolors.kRed,
                      size: 18,
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: ImageSlideshow(
                  autoPlayInterval: 15000,
                  isLoop: productnotifier.product!.imageUrls.length > 1
                      ? true
                      : false,
                  indicatorColor: Kolors.kPrimaryLight,
                  children: List.generate(
                    productnotifier.product!.imageUrls.length,
                    (i) => CachedNetworkImage(
                      height: 415.h,
                      placeholder: placeholder,
                      errorWidget: errorWidget,
                      imageUrl: productnotifier.product!.imageUrls[i],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10.h,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: productnotifier.product!.clothesType,
                      style: appStyle(13, Kolors.kGray, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Icon(
                          AntDesign.star,
                          color: Kolors.kGold,
                          size: 14,
                        ),
                        ReusableText(
                          text: productnotifier.product!.ratings
                              .toStringAsFixed(1),
                          style: appStyle(13, Kolors.kGray, FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
