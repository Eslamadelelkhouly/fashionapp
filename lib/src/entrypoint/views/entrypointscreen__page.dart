import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/src/cart/hooks/fetch_cart_count.dart';
import 'package:fashionapp/src/cart/views/cart_screen.dart';
import 'package:fashionapp/src/entrypoint/controller/bottom_tab_notifier.dart';
import 'package:fashionapp/src/home/views/home_screen.dart';
import 'package:fashionapp/src/profile/views/profile_screen.dart';
import 'package:fashionapp/src/wishlist/views/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class AppEntryPoint extends HookWidget {
  AppEntryPoint({super.key});

  List<Widget> pages = const [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final result = fetchCartCount(context);
    final count = result.cartCountModel;
    return Consumer<TabNotifier>(
      builder: (context, TabIndexNotifier, state) {
        return Scaffold(
          body: Stack(
            children: [
              pages[TabIndexNotifier.currentIndex],
              Align(
                alignment: Alignment.bottomCenter,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Kolors.kOffWhite,
                  ),
                  child: BottomNavigationBar(
                    selectedFontSize: 12,
                    elevation: 0,
                    showSelectedLabels: true,
                    selectedLabelStyle:
                        appStyle(12, Kolors.kPrimary, FontWeight.w500),
                    showUnselectedLabels: false,
                    currentIndex: TabIndexNotifier.currentIndex,
                    selectedItemColor: Kolors.kPrimary,
                    unselectedItemColor: Kolors.kGray,
                    unselectedIconTheme: IconThemeData(color: Colors.black38),
                    onTap: (i) {
                      TabIndexNotifier.setcurrentIndex(i);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: TabIndexNotifier.currentIndex == 0
                            ? Icon(
                                AntDesign.home,
                                color: Kolors.kPrimary,
                                size: 24,
                              )
                            : Icon(
                                AntDesign.home,
                                size: 24,
                              ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: TabIndexNotifier.currentIndex == 1
                            ? Icon(
                                Ionicons.heart,
                                color: Kolors.kPrimary,
                                size: 24,
                              )
                            : Icon(
                                Ionicons.heart_outline,
                                color: Kolors.kPrimary,
                                size: 24,
                              ),
                        label: 'Wishlist',
                      ),
                      BottomNavigationBarItem(
                        icon: TabIndexNotifier.currentIndex == 2
                            ? Badge(
                                label: Text(count.cartCount.toString()),
                                child: Icon(
                                  MaterialCommunityIcons.shopping,
                                  color: Kolors.kPrimary,
                                  size: 24,
                                ),
                              )
                            : Badge(
                                label: Text(count.cartCount.toString()),
                                child: Icon(
                                  MaterialCommunityIcons.shopping_outline,
                                  size: 24,
                                ),
                              ),
                        label: 'Cart',
                      ),
                      BottomNavigationBarItem(
                        icon: TabIndexNotifier.currentIndex == 3
                            ? Icon(
                                EvilIcons.user,
                                color: Kolors.kPrimary,
                                size: 34,
                              )
                            : Icon(
                                EvilIcons.user,
                                size: 34,
                              ),
                        label: 'Profile',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
