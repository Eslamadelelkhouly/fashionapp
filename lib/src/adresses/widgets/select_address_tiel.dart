import 'package:fashionapp/common/utils/app_routes.dart';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/change_address_modal.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/adresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/adresses/model/address_model.dart';
import 'package:fashionapp/src/cart/controller/cart_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SelectAddressTiel extends StatelessWidget {
  const SelectAddressTiel({
    super.key,
    required this.addressModel,
  });

  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
      builder: (context, addressNotifier, child) {
        return ListTile(
          onTap: () {
            addressNotifier.setAddress(addressModel);
            context.pop();
          },
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: Kolors.kSecondaryLight,
            child: const Icon(
              MaterialIcons.location_pin,
              color: Kolors.kPrimary,
            ),
          ),
          title: Text(
            addressModel.address ?? 'No Address',
            style: const TextStyle(
              color: Kolors.kPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            '${addressModel.phone ?? ''}\n${addressModel.addressType ?? ''}',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          trailing: ReusableText(
            text: addressNotifier.address != null &&
                    addressNotifier.address!.id == addressModel.id
                ? "Selected"
                : "Select",
            style: appStyle(12, Kolors.kPrimaryLight, FontWeight.w400),
          ),
        );
      },
    );
  }
}
