// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../consts/login_sliders.dart';
import '../../../imports.dart';
import '../../../screens/log_in/log_in_screen.dart';
import '../../../screens/sign_up/sign_up_screen.dart';
import '../../flexus_framework.dart';
import 'front_controller.dart';
import 'widgets/front_slider_item.dart';

class FxFrontScreen extends ScreenMaster<FxFrontController> {
  const FxFrontScreen({Key? key}) : super(key: key);
  @override
  Widget create() {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo_1024.png",
                        height: 6.h,
                      ),
                      SizedBox(width: 2.w),
                      Text(FlexusController.to.title.value)
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  child: CarouselSlider(
                    carouselController: controller.loginSliderController,
                    options: CarouselOptions(
                        viewportFraction: 1.0,
                        height: 40.h,
                        onPageChanged: (index, reason) {
                          controller.currentSlider.value = index;
                        }),
                    items: FlexusController.to.frontSliderItems
                        .map((FxFrontSliderItem sliderItem) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  sliderItem.image,
                                  height: 30.h,
                                ),
                                SizedBox(height: 1.h),
                                Text(sliderItem.title,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 1.h),
                                Text(sliderItem.description,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat())
                              ]);
                        },
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: FlexusController.to.frontSliderItems
                      .asMap()
                      .entries
                      .map((entry) {
                    return GestureDetector(
                      onTap: () => controller.loginSliderController
                          .animateToPage(entry.key),
                      child: Obx(
                        () => Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(Get.context!).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Theme.of(Get.context!)
                                          .colorScheme
                                          .primary)
                                  .withOpacity(controller.currentSlider.value ==
                                          entry.key
                                      ? 0.9
                                      : 0.4)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 4.h),
                SizedBox(
                  height: 20.h,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 75.w,
                        height: 48,
                        child: ElevatedButton(
                          child: Text(Trns.signUp.val),
                          onPressed: () {
                            Get.to(() => FxSignUpScreen());
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        width: 75.w,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white, onPrimary: Colors.black),
                          child: Text(Trns.signIn.val),
                          onPressed: () {
                            Get.to(
                                () => const FxLoginScreen(LoginSliders.login));
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
