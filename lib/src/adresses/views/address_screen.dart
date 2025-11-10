import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressScreen extends HookWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      bottomNavigationBar: Consumer<CartNotifier>(
        builder: (context, cartNotitifer, child) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              height: 80,
              width: ScreenUtil().scaleWidth,
              decoration: BoxDecoration(
                color: Kolors.kPrimaryLight,
                borderRadius: kRadiusTop,
              ),
              child: Center(
                child: ReusableText(
                  text: "Add Address",
                  style: appStyle(16, Kolors.kOffWhite, FontWeight.w600),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
