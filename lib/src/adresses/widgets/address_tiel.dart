import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/adresses/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
    return ListTile(
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (isCheckout == true) {
                // change address bottom sheat
              } else {}
            },
            child: Container(
              child: ReusableText(
                text: "Change",
                style: appStyle(12, Kolors.kWhite, FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
