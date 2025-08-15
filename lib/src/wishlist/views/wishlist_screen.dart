import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/auth/views/login_screen.dart';
import 'package:fashionapp/src/product/widgets/explore_product.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) {
      return LoginScreen();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: ReusableText(
          text: 'Wishlist',
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: ExploreProduct(),
    );
  }
}
