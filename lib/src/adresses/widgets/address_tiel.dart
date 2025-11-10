import 'dart:developer';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/change_address_modal.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/adresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/adresses/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class AddressTiel extends StatelessWidget {
  const AddressTiel({
    super.key,
    required this.addressModel,
    required this.isCheckout,
    this.setDefault,
    this.onDelete,
  });

  final AddressModel addressModel;
  final bool isCheckout;
  final void Function()? setDefault;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
      builder: (context, addressNotifier, child) {
        final bool isDefaultAddress = addressModel.isDefault ?? false;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Kolors.kOffWhite,
            borderRadius: kRadiusAll,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
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
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 🌟 Set Default Button
                GestureDetector(
                  onTap: () {
                    if (isCheckout) {
                      changeAddressBottomSheet(context);
                    } else if (!isDefaultAddress) {
                      // بس لو مش افتراضي بالفعل
                      addressModel.isDefault ? () {} : setDefault!();
                      setDefault?.call();
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: kRadiusAll,
                      color: isCheckout
                          ? Kolors.kPrimary
                          : isDefaultAddress
                              ? Colors.green
                              : Kolors.kGrayLight,
                    ),
                    child: ReusableText(
                      text: isCheckout
                          ? "Change"
                          : isDefaultAddress
                              ? "Default"
                              : "Set Default",
                      style: appStyle(12, Kolors.kWhite, FontWeight.w500),
                    ),
                  ),
                ),

                // 🗑 Delete Button (hidden in checkout)
                if (isCheckout == true || addressModel.isDefault)
                  GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Kolors.kRed,
                        borderRadius: kRadiusAll,
                      ),
                      child: ReusableText(
                        text: 'Delete',
                        style: appStyle(12, Kolors.kWhite, FontWeight.w500),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
