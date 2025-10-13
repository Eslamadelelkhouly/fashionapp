import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:flutter/material.dart';
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
        return GestureDetector();
      },
    );
  }
}
