import 'dart:developer';
import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/email_textfield.dart';
import 'package:fashionapp/common/widgets/empty_screen_widget.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/product/widgets/stagred_title_widget.dart';
import 'package:fashionapp/src/search/controller/search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.read<SearchNotifier>().clearResults();
            context.pop();
          },
        ),
        title: ReusableText(
          text: AppText.kSearch,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: EmailTextField(
              controller: _searchController,
              radius: 30,
              hintText: AppText.kSearchHint,
              prefixIcon: GestureDetector(
                onTap: () {
                  if (_searchController.text.isNotEmpty) {
                    context
                        .read<SearchNotifier>()
                        .searchFunction(_searchController.text);
                  } else {
                    log('Search key is empty');
                  }
                },
                child: const Icon(
                  AntDesign.search1,
                  color: Kolors.kPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<SearchNotifier>(
        builder: (context, searchnotifer, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: ListView(
              children: [
                searchnotifer.results.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReusableText(
                            text: AppText.kSearchResults,
                            style: appStyle(
                              13,
                              Kolors.kPrimary,
                              FontWeight.w600,
                            ),
                          ),
                          ReusableText(
                            text: AppText.kSearchResults,
                            style: appStyle(
                              13,
                              Kolors.kPrimary,
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 10.h,
                ),
                searchnotifer.results.isNotEmpty
                    ? StaggeredGrid.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: List.generate(
                          searchnotifer.results.length,
                          (index) {
                            final double mainAxisCellCount =
                                (index % 2 == 0 ? 4.2 : 2.7);

                            return StaggeredGridTile.count(
                              crossAxisCellCount: 2,
                              mainAxisCellCount: mainAxisCellCount,
                              child: StagredTitleWidget(
                                product: searchnotifer.results[index],
                                i: index,
                                onTab: () {
                                  if (accessToken == null) {
                                    loginBottomSheet(context);
                                  } else {
                                    // handel wishlist action
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      )
                    : EmptyScreenWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
