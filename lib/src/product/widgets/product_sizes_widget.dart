import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/src/products/controller/color_sized_notifier.dart';
import 'package:fashionapp/src/products/controller/products_notifier.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductSizesWidget extends StatelessWidget {
  const ProductSizesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSizedNotifier>(
      builder: (context, controller, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            context.read<ProductsNotifier>().product!.sizes.length,
            (index) {
              String s = context.read<ProductsNotifier>().product!.sizes[index];
              return GestureDetector(
                onTap: () {
                  controller.setSize(s);
                },
                child: Container(
                  height: 30.h,
                  width: 45.h,
                  decoration: BoxDecoration(
                    color: controller.size == s
                        ? Kolors.kPrimary
                        : Kolors.kGrayLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      s,
                      style: appStyle(
                        20,
                        Kolors.kWhite,
                        FontWeight.bold,
                      ),
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
