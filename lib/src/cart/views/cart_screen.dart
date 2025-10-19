import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/password_field.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashionapp/src/auth/views/login_screen.dart';
import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:fashionapp/src/cart/hooks/fetch_cart.dart';
import 'package:fashionapp/src/cart/widgets/cart_tiel.dart';
import 'package:fashionapp/src/home/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartScreen extends HookWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final result = fetchCart();
    final carts = result.listCartModel;
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
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: ReusableText(
          text: 'Cart',
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 33.h),
          children: List.generate(
            carts.length,
            (i) {
              final cart = carts[i];
              return CartTiel(
                cartModel: cart,
                onUpdate: () {
                  context.read<CartNotifier>().updateCart(cart.id, refetch);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
