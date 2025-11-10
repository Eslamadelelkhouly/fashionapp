import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/src/adresses/hooks/fetch_address_list.dart';
import 'package:fashionapp/src/adresses/widgets/address_tiel.dart';
import 'package:fashionapp/src/adresses/widgets/select_address_tiel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutAddressList extends HookWidget {
  const CheckoutAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    final rztl = fetchAddress();
    final isLoading = rztl.isLoading;
    final addresses = rztl.addressModels;

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: const ListShimmer(),
      );
    }
    return ListView(
      children: List.generate(
        addresses.length,
        (i) {
          return SelectAddressTiel(
            addressModel: addresses[i],
          );
        },
      ),
    );
  }
}
