import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/src/auth/views/login_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) {
      return LoginScreen();
    }
    return const Scaffold(
      body: Center(
        child: Text('Cart Screen'),
      ),
    );
  }
}
