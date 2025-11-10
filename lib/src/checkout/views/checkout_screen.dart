import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/adresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/adresses/hooks/fetch_default.dart';
import 'package:fashionapp/src/adresses/widgets/address_block.dart';
import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:fashionapp/src/checkout/widget/checkout_tiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends HookWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rztl = fetchDefaultAddress(context);
    final addressNotifier = Provider.of<AddressNotifier>(context);
    final cartNotifier = Provider.of<CartNotifier>(context);

    final isLoading = rztl.isLoading;
    final address = addressNotifier.address;

    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(onTap: () {
          context.read<AddressNotifier>().clearAddress();
          context.pop();  
        }),
        title: ReusableText(
          text: AppText.kCheckout,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        children: [
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (address != null)
            AddressBlock(addressModel: address)
          else
            GestureDetector(
              onTap: () => context.push('/address'),
              child: Container(
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Kolors.kPrimary),
                ),
                child: ReusableText(
                  text: 'Please select your location',
                  style: appStyle(14, Kolors.kPrimary, FontWeight.w500),
                ),
              ),
            ),
          SizedBox(height: 10.h),
          if (cartNotifier.selectedCartItem.isNotEmpty)
            SizedBox(
              height: ScreenUtil().screenHeight * 0.5,
              child: Column(
                children: List.generate(
                  cartNotifier.selectedCartItem.length,
                  (i) => CheckoutTiel(
                    cartModel: cartNotifier.selectedCartItem[i],
                  ),
                ),
              ),
            ),
        ],
      ),
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
                  text: address == null
                      ? "Please an address"
                      : "Continue to Paayment",
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
