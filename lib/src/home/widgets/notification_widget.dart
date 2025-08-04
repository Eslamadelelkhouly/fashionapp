import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: CircleAvatar(
          backgroundColor: Kolors.kGrayLight.withOpacity(0.3),
        child: Badge(
          label: Text('4'),
          child: Icon(Ionicons.notifications , color: Kolors.kPrimary,),
        ),
        ),

        
      ),
    );
  }
}
