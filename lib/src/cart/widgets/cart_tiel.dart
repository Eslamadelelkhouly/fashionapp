import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class CartTiel extends StatelessWidget {
  const CartTiel(
      {super.key, required this.cartModel, this.onDelete, this.onUpdate});
  final CartModel cartModel;
  final void Function()? onDelete;
  final void Function()? onUpdate;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartNotifier>(
      builder: (context, cartnotifier, child) {
        return GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Container(
              width: ScreenUtil().scaleWidth,
              height: 90.h,
              decoration: BoxDecoration(
                color: Kolors.kWhite,
                borderRadius: kRadiusAll,
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 85.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Kolors.kWhite,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: kRadiusAll,
                                child: SizedBox(
                                  width: 76.w,
                                  height: double.infinity,
                                  child: CachedNetworkImage(
                                    imageUrl: cartModel.product.imageUrl[0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                child: GestureDetector(
                                  onTap: onDelete,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      AntDesign.delete,
                                      size: 14,
                                      color: Kolors.kWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReusableText(
                              text: cartModel.product.title.toUpperCase(),
                              style:
                                  appStyle(12, Kolors.kDark, FontWeight.normal),
                            ),
                            ReusableText(
                              text:
                                  'Size: ${cartModel.size} || Color: ${cartModel.color}'
                                      .toUpperCase(),
                              style:
                                  appStyle(12, Kolors.kDark, FontWeight.normal),
                            ),
                            SizedBox(
                              width: ScreenUtil().screenWidth * 0.5,
                              child: Text(
                                cartModel.product.description,
                                maxLines: 2,
                                textAlign: TextAlign.justify,
                                style: appStyle(
                                    9, Kolors.kGray, FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 6.0, left: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 35.w,
                            height: 20.h,
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
                        Padding(
                          padding: EdgeInsets.only(right: 6.w),
                          child: ReusableText(
                            text:
                                "\$ ${(cartModel.quantity * cartModel.product.price).toStringAsFixed(2)}",
                            style:
                                appStyle(12, Kolors.kPrimary, FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
