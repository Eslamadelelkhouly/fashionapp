import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/home/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                    'Please select your location',
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
    );
  }
}
