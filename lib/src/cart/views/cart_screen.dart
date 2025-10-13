import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/src/auth/views/login_screen.dart';
import 'package:fashionapp/src/cart/hooks/fetch_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends HookWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final result = fetchCart();
    final cart = result.listCartModel;
    final isLoading = result.isLoading;
    final refetch = result.refetch;
    final error = result.error;

    if (accessToken == null) {
      return LoginScreen();
    }

    if (isLoading) {
      return Scaffold(
        body: ListShimmer(),
      );
    }
    return Scaffold(
      body: Center(
        child: ListView(
          children: List.generate(
            cart.length,
            (i) {
              return Container(
                width: ScreenUtil().scaleWidth,
                height: 100,
                color: Kolors.kPrimary,
              );
            },
          ),
        ),
      ),
    );
  }
}
