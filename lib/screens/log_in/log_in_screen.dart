import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../imports.dart';
import '../../widgets/login_button.dart';
import 'log_in_controller.dart';
import 'sliders/forgot_password_slider.dart';
import 'sliders/login_slider.dart';
import 'sliders/verify_email_slider.dart';

class FxLoginScreen extends ScreenMaster<FxLogInController> {
  final int? initialPage;
  FxLoginScreen(this.initialPage);
  @override
  Widget create() {
    return ScaffoldMaster(Trns.signIn.val,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        body: Obx(
          () => LoadingOverlay(
            opacity: 0.0,
            isLoading: controller.isLoading.value,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginButton(
                        Trns.signInWithGoogle.val,
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          color: Colors.red,
                          size: 24.0,
                        ),
                        onClick: () {
                          controller.signInWithGoogle();
                        },
                      ),
                      LoginButton(
                        Trns.signInWithFacebook.val,
                        icon: const Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                          size: 24.0,
                        ),
                        onClick: () {
                          controller.signInWithFacebook();
                        },
                      ),
                      if (Platform.isIOS)
                        LoginButton(
                          Trns.signInWithApple.val,
                          icon: const Icon(
                            FontAwesomeIcons.apple,
                            color: Colors.black,
                            size: 24.0,
                          ),
                          onClick: () {
                            controller.signInWithApple();
                          },
                        ),
                      SizedBox(height: 4.h),
                      const Text("OR"),
                    ],
                  ),
                ),
                CarouselSlider(
                  carouselController: controller.loginSliderController,
                  options: CarouselOptions(
                      height: 60.h,
                      viewportFraction: 1,
                      initialPage: initialPage!,
                      scrollPhysics: const NeverScrollableScrollPhysics()),
                  items: [
                    FxLoginSlider(),
                    FxVerifyEmailSlider(),
                    FxForgotPasswordSlider()
                  ],
                )
              ]),
            ),
          ),
        ));
  }
}
