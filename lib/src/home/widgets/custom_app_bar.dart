import 'package:fashionapp/common/utils/app_routes.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/adresses/hooks/fetch_default.dart';
import 'package:fashionapp/src/home/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends HookWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final rztl = fetchDefaultAddress();

    final address =
        rztl?.addressModel?.address ?? 'Please select your location';
    print(address);
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 3.0),
            child: ReusableText(
              text: 'Location',
              style: appStyle(12, Kolors.kGray, FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Icon(
                Ionicons.location,
                color: Kolors.kPrimary,
                size: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: SizedBox(
                  width: ScreenUtil().screenWidth * 0.7,
                  child: Text(
                    address,
                    style: appStyle(
                      14,
                      Kolors.kDark,
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        NotificationWidget(),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: GestureDetector(
          onTap: () {
            context.push('/search');
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.0.h,
              vertical: 8.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40.h,
                  width: ScreenUtil().screenWidth - 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5.h,
                      color: Kolors.kGrayLight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0.h, vertical: 8.h),
                    child: Row(
                      children: [
                        Icon(
                          Ionicons.search,
                          size: 20,
                          color: Kolors.kPrimary,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        ReusableText(
                          text: 'Search Product',
                          style: appStyle(14, Kolors.kGray, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 40.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                    color: Kolors.kPrimary,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    FontAwesome.sliders,
                    color: Kolors.kWhite,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
