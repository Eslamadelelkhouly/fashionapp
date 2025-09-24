import 'dart:developer';

import 'package:fashionapp/common/utils/app_routes.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/email_textfield.dart';
import 'package:fashionapp/common/widgets/password_field.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/search/controller/search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    );
  }
}
