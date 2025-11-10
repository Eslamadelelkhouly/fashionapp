import 'dart:developer';
import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/utils/kstrings.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/custom_button.dart';
import 'package:fashionapp/common/widgets/error_modal.dart';
import 'package:fashionapp/common/widgets/reusable_text.dart';
import 'package:fashionapp/const/constants.dart';
import 'package:fashionapp/src/adresses/controllers/address_notifier.dart';
import 'package:fashionapp/src/adresses/model/create_address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _addressController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Center(
          child: ReusableText(
            text: AppText.kAddShipping,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
          ),
        ),
      ),
      body: Consumer<AddressNotifier>(
        builder: (context, addressnotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            children: [
              SizedBox(height: 20.h),

              // Phone Number
              _buildTextField(
                hintText: 'Phone Number',
                keyboard: TextInputType.phone,
                controller: _phoneController,
                onSubmitted: (p) {},
              ),
              SizedBox(height: 20.h),

              // Address
              _buildTextField(
                hintText: 'Address',
                keyboard: TextInputType.text,
                controller: _addressController,
                onSubmitted: (p) {},
              ),
              SizedBox(height: 20.h),

              // Address Types Buttons
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                      List.generate(addressnotifier.addressTypes.length, (i) {
                    final addressType = addressnotifier.addressTypes[i];
                    return GestureDetector(
                      onTap: () {
                        addressnotifier.setAddressType(addressType);
                        log('Selected type: $addressType');
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: addressnotifier.addresstype == addressType
                              ? Kolors.kPrimaryLight
                              : Kolors.kWhite,
                          borderRadius: kRadiusAll,
                          border: Border.all(
                            color: Kolors.kPrimary,
                            width: 1,
                          ),
                        ),
                        child: ReusableText(
                          text: addressType,
                          style: appStyle(
                            12,
                            addressnotifier.addresstype == addressType
                                ? Kolors.kWhite
                                : Kolors.kPrimary,
                            FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: "Set this address as default",
                      style: appStyle(
                        14,
                        Kolors.kPrimary,
                        FontWeight.normal,
                      ),
                    ),
                    CupertinoSwitch(
                      value: addressnotifier.defaultToggle,
                      thumbColor: Kolors.kSecondaryLight,
                      activeColor: Kolors.kPrimary,
                      onChanged: (d) {
                        addressnotifier.setDefaultToggle(d);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              GradientBtn(
                text: "S U B M I T",
                btnHieght: 35,
                radius: 9,
                onTap: () {
                  if (_addressController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      addressnotifier.addressTypes != "") {
                    CreateAddress address = CreateAddress(
                        lat: 0.0,
                        lng: 0.0,
                        isDefault: addressnotifier.defaultToggle,
                        address: _addressController.text,
                        phone: _phoneController.text,
                        addressType: addressnotifier.addresstype);

                    String data = createAddressToJson(address);
                    addressnotifier.addAddres(data, context);
                    log(data);
                  } else {
                    showErrorPopup(context, 'You have Missing Address Fields',
                        'Error Adding Address', false);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _buildTextField extends StatelessWidget {
  const _buildTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onSubmitted,
    this.keyboard,
    this.readOnly,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboard;
  final void Function(String)? onSubmitted;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: TextField(
        keyboardType: keyboard,
        readOnly: readOnly ?? false,
        controller: controller,
        cursorHeight: 25,
        style: appStyle(12, Colors.black, FontWeight.normal),
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText, // ✅ الآن سيظهر
          hintStyle: appStyle(12, Colors.grey, FontWeight.normal),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Kolors.kPrimary, width: 0.5),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
          ),
        ),
      ),
    );
  }
}
