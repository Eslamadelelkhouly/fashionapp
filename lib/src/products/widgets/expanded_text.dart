import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/src/products/controller/products_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandedText extends StatelessWidget {
  const ExpandedText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.justify,
          maxLines: !context.watch<ProductsNotifier>().description ? 3 : 10,
          style: appStyle(13, Kolors.kGray, FontWeight.normal),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                context.read<ProductsNotifier>().setDescription();
              },
              child: Text(
                !context.watch<ProductsNotifier>().description
                    ? "View More"
                    : "View Less",
                style: appStyle(11, Kolors.kPrimaryLight, FontWeight.normal),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
