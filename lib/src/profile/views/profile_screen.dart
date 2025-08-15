import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/custom_button.dart';
import 'package:fashionapp/common/widgets/help_bottom_sheet.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/profile/widgets/profile_tiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            CircleAvatar(
              radius: 35,
              backgroundColor: Kolors.kOffWhite,
              backgroundImage: NetworkImage(AppText.kProfilePic),
            ),
            SizedBox(
              height: 15.h,
            ),
            ReusableText(
              text: 'toka@gmail.com',
              style: appStyle(
                11,
                Kolors.kGray,
                FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ReusableText(
                text: 'Toka elkhouly',
                style: appStyle(14, Kolors.kDark, FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Container(
          color: Kolors.kOffWhite,
          child: Column(
            children: [
              ProfileTiel(
                leading: Octicons.checklist,
                title: 'My Orders',
                onTap: () {
                  context.push('/orders');
                },
              ),
              ProfileTiel(
                leading: MaterialIcons.location_pin,
                title: 'Shipping Address',
                onTap: () {
                  context.push('/addaddress');
                },
              ),
              ProfileTiel(
                leading: MaterialIcons.policy,
                title: 'Privacy Policy',
                onTap: () {
                  context.push('/policy');
                },
              ),
              ProfileTiel(
                leading: AntDesign.customerservice,
                title: 'Help Center',
                onTap: () => showHelpCenterBottomSheet(context),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: GradientBtn(
                  text: 'Logout'.toUpperCase(),
                  btnColor: Kolors.kRed,
                  btnHieght: 35,
                  btnWidth: ScreenUtil().screenWidth,
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
