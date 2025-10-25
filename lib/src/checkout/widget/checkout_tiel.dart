import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CheckoutTiel extends StatelessWidget {
  const CheckoutTiel({super.key, required this.cartModel});
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartnotifier, child) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Container(
            width: double.infinity,
            height: 90.h,
            decoration: BoxDecoration(
              color: Kolors.kPrimaryLight.withOpacity(0.2),
              borderRadius: kRadiusAll,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // صورة المنتج
                Container(
                  width: 76.w,
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: Kolors.kWhite,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: kRadiusAll,
                    child: CachedNetworkImage(
                      imageUrl: cartModel.product.imageUrls[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(width: 10.w),

                // نصوص المنتج (العنوان والوصف)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ReusableText(
                        text: cartModel.product.title.toUpperCase(),
                        style: appStyle(12, Kolors.kDark, FontWeight.w500),
                      ),
                      ReusableText(
                        text:
                            'Size: ${cartModel.size} | Color: ${cartModel.color}'
                                .toUpperCase(),
                        style: appStyle(11, Kolors.kDark, FontWeight.normal),
                      ),
                      Text(
                        cartModel.product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(9, Kolors.kGray, FontWeight.normal),
                      ),
                    ],
                  ),
                ),

                // السعر والكمية
                Padding(
                  padding: EdgeInsets.only(right: 6.w, left: 3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<CartNotifier>().setSelectedCounter(
                                cartModel.id,
                                cartModel.quantity,
                              );
                        },
                        child: Container(
                          width: 35.w,
                          height: 20.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Kolors.kPrimary,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: ReusableText(
                            text: "* ${cartModel.quantity}",
                            style: appStyle(
                              12,
                              Kolors.kPrimary,
                              FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      ReusableText(
                        text:
                            "\$ ${(cartModel.quantity * cartModel.product.price).toStringAsFixed(2)}",
                        style: appStyle(12, Kolors.kPrimary, FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
