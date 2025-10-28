import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/src/adresses/model/address_model.dart';
import 'package:fashionapp/src/adresses/widgets/address_tiel.dart';
import 'package:flutter/material.dart';

class AddressBlock extends StatelessWidget {
  const AddressBlock({super.key, this.addCartModel});
  final AddressModel? addCartModel;

  @override
  Widget build(BuildContext context) {
    // ✅ إذا مفيش عنوان، نظهر رسالة بدل الكراش
    if (addCartModel == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(
            text: 'Shipping Address',
            style: appStyle(
              13,
              Kolors.kPrimary,
              FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'No address available',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      );
    }

    // ✅ لو العنوان موجود نعرضه
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
          text: 'Shipping Address',
          style: appStyle(
            13,
            Kolors.kPrimary,
            FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        AddressTiel(
          addressModel: addCartModel!,
          isCheckout: true,
        ),
      ],
    );
  }
}
