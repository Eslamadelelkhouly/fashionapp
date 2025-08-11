import 'package:fashionapp/src/home/controller/home_tab_notifier.dart';
import 'package:fashionapp/src/home/widgets/categories_list.dart';
import 'package:fashionapp/src/home/widgets/custom_app_bar.dart';
import 'package:fashionapp/src/home/widgets/home_header.dart';
import 'package:fashionapp/src/home/widgets/home_slider.dart';
import 'package:fashionapp/src/home/widgets/home_tabs.dart';
import 'package:fashionapp/src/product/widgets/explore_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: homeTabs.length, vsync: this);
    _tabController.addListener(_handelSelection);
    super.initState();
  }

  void _handelSelection() {
    final controller = Provider.of<HomeTabNotifier>(context, listen: false);

    if (_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
      });
      controller.setIndex(homeTabs[_currentIndex]);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.removeListener(_handelSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: CustomAppBar(),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: [
          SizedBox(
            height: 20.h,
          ),
          const HomeSlider(),
          SizedBox(
            height: 15.h,
          ),
          const HomeHeader(),
          SizedBox(
            height: 10.h,
          ),
          const CategoriesList(),
          SizedBox(
            height: 15.h,
          ),
          HomeTabs(tabController: _tabController),
          SizedBox(
            height: 15.h,
          ),
          ExploreProduct(),
        ],
      ),
    );
  }
}

List<String> homeTabs = ['All', 'Popular', 'Unisex', 'Men', 'Women', 'Kids'];
