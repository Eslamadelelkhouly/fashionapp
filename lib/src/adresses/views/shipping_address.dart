import 'dart:developer';

import 'package:fashionapp/common/utils/app_routes.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/adresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/adresses/hooks/fetch_address_list.dart';
import 'package:fashionapp/src/adresses/widgets/address_tiel.dart';
import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShippingAddress extends HookWidget {
  const ShippingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchAddress();
    final isLoading = results.isLoading;
    final addresses = results.addressModels;
    final refetch = results.refetch;
    if (isLoading) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: ListShimmer(),
        ),
      );
    }
    context.read<AddressNotifier>().setRefetch(refetch);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Center(
          child: ReusableText(
            text: AppText.kAddresses,
            style: appStyle(
              16,
              Kolors.kPrimary,
              FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: List.generate(
          addresses.length,
          (i) {
            final address = addresses[i];
            return AddressTiel(
              onDelete: () {
                log('delete');
                context
                    .read<AddressNotifier>()
                    .deleteAddress(address.id,  context);
              },
              setDefault: () {
                log('default');
                context
                    .read<AddressNotifier>()
                    .setAsDefault(address.id, refetch, context);
              },
              addressModel: address,
              isCheckout: false,
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<CartNotifier>(
        builder: (context, cartNotitifer, child) {
          return GestureDetector(
            onTap: () {
              context.push('/addresses');
            },
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
