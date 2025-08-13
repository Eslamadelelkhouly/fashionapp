import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/products/controller/color_sized_notifier.dart';
import 'package:fashionapp/src/products/controller/products_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductColorWidget extends StatelessWidget {
  const ProductColorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSizedNotifier>(
      builder: (context, controller, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            context.read<ProductsNotifier>().product!.colors.length,
            (index) {
              String c =
                  context.read<ProductsNotifier>().product!.colors[index];
              return GestureDetector(
                onTap: () {
                  controller.setColor(c);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 20.w, left: 20.w),
                  margin: EdgeInsets.only(right: 20.w),
                  decoration: BoxDecoration(
                    color: c == controller.color
                        ? Kolors.kPrimary
                        : Kolors.kGrayLight,
                    borderRadius: kRadiusAll,
                  ),
                  child: ReusableText(
                    text: c,
                    style: appStyle(
                      12,
                      Kolors.kWhite,
                      FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
