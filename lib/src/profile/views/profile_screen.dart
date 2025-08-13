import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/custom_button.dart';
import 'package:fashionapp/common/widgets/help_bottom_sheet.dart';
import 'package:fashionapp/src/profile/widgets/profile_tiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          children: [],
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
                onTap: () {},
              ),
              ProfileTiel(
                leading: MaterialIcons.location_pin,
                title: 'Shipping Address',
                onTap: () {},
              ),
              ProfileTiel(
                leading: MaterialIcons.policy,
                title: 'Privacy Policy',
                onTap: () {},
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
