import 'package:fashionapp/common/utils/app_routes.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:fashionapp/src/checkout/widget/checkout_tiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.pop();
          },
        ),
        title: ReusableText(
          text: AppText.kCheckout,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<CartNotifier>(
        builder: (context, cartnotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: ScreenUtil().screenHeight * 0.5,
                child: Column(
                  children: List.generate(
                    cartnotifier.selectedCartItem.length,
                    (i) {
                      return CheckoutTiel(
                        cartModel: cartnotifier.selectedCartItem[i],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
