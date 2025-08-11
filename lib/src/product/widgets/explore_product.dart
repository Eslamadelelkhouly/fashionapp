import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/widgets/login_bottom_sheet.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/product/widgets/stagred_title_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExploreProduct extends StatelessWidget {
  const ExploreProduct({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: List.generate(
          products.length,
          (index) {
            final double mainAxisCellCount = (index % 2 == 0 ? 4.2 : 2.7);

            return StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: mainAxisCellCount,
              child: StagredTitleWidget(
                product: products[index],
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
      ),
    );
  }
}
