import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/custom_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kRadiusAll,
      child: Stack(
        children: [
          SizedBox(
            height: ScreenUtil().screenHeight * 0.16,
            width: ScreenUtil().screenWidth,
            child: ImageSlideshow(
              autoPlayInterval: 5000,
              isLoop: true,
              indicatorColor: Kolors.kPrimaryLight,
              onPageChanged: (value) {},
              children: List.generate(
                images.length,
                (i) => CachedNetworkImage(
                  placeholder: placeholder,
                  errorWidget: errorWidget,
                  imageUrl: images[i],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            height: ScreenUtil().screenHeight * 0.16,
            width: ScreenUtil().screenWidth,
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: AppText.kCollection,
                      style: appStyle(
                        20,
                        Kolors.kDark,
                        FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Discount 50% off \nthe first transaction',
                      style: appStyle(
                          14, Kolors.kDark.withOpacity(.6), FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GradientBtn(
                      text: 'Shop Now',
                      btnColor: Kolors.kPrimaryLight,
                      btnWidth: 150.w,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> images = [
  'https://as2.ftcdn.net/jpg/03/67/56/57/1000_F_367565758_Jw4B5XL7wdPekEWywKPihQbwwzC9B1ZL.jpg',
  'https://as2.ftcdn.net/jpg/04/15/97/33/1000_F_415973312_5yg3MrkRdi2SMHyVKbB4h7GgE5HrgUlb.jpg',
  'http://as2.ftcdn.net/jpg/04/78/75/27/1000_F_478752729_bvtlb01LHcdjCOWvuS35GUbcnlP8ynpp.jpg',
];
