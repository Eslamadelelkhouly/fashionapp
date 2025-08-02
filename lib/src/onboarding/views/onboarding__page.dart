import 'package:fashionapp/src/onboarding/controller/onboarding_notifier.dart';
import 'package:fashionapp/src/onboarding/widgets/onboarding__pageone.dart';
import 'package:fashionapp/src/onboarding/widgets/onboarding__pagetwo.dart';
import 'package:fashionapp/src/onboarding/widgets/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(
      initialPage: context.read<OnboardingNotifier>().selectedPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (page) {
              context.read<OnboardingNotifier>().selectedPage = page;
            },
            children: [
              OnBoardingOne(),
              OnBoardingTwo(),
              WelcomScreen(),
            ],
          ),
        ],
      ),
    );
  }
}
