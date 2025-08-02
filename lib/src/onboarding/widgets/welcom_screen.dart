import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/custom_button.dart';
import 'package:fashionapp/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomScreen extends StatelessWidget {
  const WelcomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            Image.asset(R.ASSETS_IMAGES_GETSTARTED_PNG, fit: BoxFit.cover),
            SizedBox(
              height: 30.h,
            ),
            Text(
              AppText.kWelcomeHeader,
              textAlign: TextAlign.center,
              style: appStyle(24, Kolors.kPrimary, FontWeight.bold),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: ScreenUtil().screenWidth - 100,
              child: Text(
                AppText.kWelcomeMessage,
                textAlign: TextAlign.center,
                style: appStyle(11, Kolors.kGray, FontWeight.normal),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            GradientBtn(
              text: AppText.kGetStarted,
              onTap: () {},
              btnHieght: 35,
              radius: 20,
              btnWidth: ScreenUtil().screenWidth - 100,
            ),
          ],
        ),
      ),
    );
  }
}
