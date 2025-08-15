import 'package:fashionapp/common/utils/kcolors.dart';
import 'package:fashionapp/common/widgets/app_style.dart';
import 'package:fashionapp/common/widgets/back_button.dart';
import 'package:fashionapp/common/widgets/custom_button.dart';
import 'package:fashionapp/common/widgets/email_textfield.dart';
import 'package:fashionapp/common/widgets/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: AppBackButton(),
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 160.h,
          ),
          Text(
            'Dbest Fashion',
            textAlign: TextAlign.center,
            style: appStyle(24, Kolors.kPrimary, FontWeight.bold),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Hi! Welcome back. You \'ve been missed',
            textAlign: TextAlign.center,
            style: appStyle(13, Kolors.kGray, FontWeight.normal),
          ),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                EmailTextField(
                  radius: 25,
                  focusNode: _passwordFocusNode,
                  hintText: 'Email',
                  controller: _emailController,
                  prefixIcon: Icon(CupertinoIcons.mail),
                  keyboardType: TextInputType.name,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                ),
                SizedBox(
                  height: 25.h,
                ),
                PasswordField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  radius: 25,
                ),
                SizedBox(
                  height: 20.h,
                ),
                GradientBtn(
                  onTap: () {},
                  text: 'L O G I N',
                  btnWidth: ScreenUtil().screenWidth,
                  btnHieght: 40,
                  radius: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 130.h,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 110.h),
            child: GestureDetector(
              onTap: () {
                context.push('/register');
              },
              child: Text(
                'Do not have an account? Register a new one',
                style: appStyle(12, Colors.blue, FontWeight.normal),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
