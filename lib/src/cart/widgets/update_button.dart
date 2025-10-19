import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/main.dart';
import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, this.onUpdate, this.onCancel});
  final void Function()? onUpdate;
  final void Function()? onCancel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context.read<CartNotifier>().clearSelected();
      },
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
