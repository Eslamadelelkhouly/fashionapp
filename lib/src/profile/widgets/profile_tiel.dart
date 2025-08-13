import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProfileTiel extends StatelessWidget {
  const ProfileTiel(
      {super.key, this.onTap, required this.leading, required this.title});
  final void Function()? onTap;
  final IconData leading;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      leading: Icon(
        leading,
        color: Kolors.kGray,
      ),
      title: Text(
        title,
        style: appStyle(13, Kolors.kDark, FontWeight.normal),
      ),
      trailing: const Icon(
        AntDesign.right,
        size: 16,
        color: Kolors.kDark,
      ),
    );
  }
}
