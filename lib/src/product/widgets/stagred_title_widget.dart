import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/product/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class StagredTitleWidget extends StatelessWidget {
  const StagredTitleWidget(
      {super.key, required this.i, required this.product, this.onTab});
  final int i;
  final Products product;
  final void Function()? onTab;
  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Kolors.kOffWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: i % 2 == 0 ? 163.h : 180.h,
                color: Kolors.kPrimary,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      height: i % 2 == 0 ? 163.h : 180.h,
                      fit: BoxFit.cover,
                      imageUrl: product.imageUrls[0],
                    ),
                    Positioned(
                      right: 10.h,
                      top: 10.h,
                      child: CircleAvatar(
                        backgroundColor: Kolors.kSecondaryLight,
                        child: Icon(
                          AntDesign.heart,
                          color: Kolors.kRed,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(12, Kolors.kDark, FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          AntDesign.star,
                          color: Kolors.kGold,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ReusableText(
                          text: product.ratings.toStringAsFixed(1),
                          style: appStyle(
                            13,
                            Kolors.kGray,
                            FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: ReusableText(
                  text: '\$ ${product.price.toStringAsFixed(2)}',
                  style: appStyle(17, Kolors.kDark, FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
