import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, this.onUpdate});
  final void Function()? onUpdate;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpdate,
      child: Container(
        width: 65.w,
        height: 18.h,
        decoration: BoxDecoration(
          color: Kolors.kPrimaryLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: ReusableText(
            text: 'Update',
            style: appStyle(11, Kolors.kWhite, FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
