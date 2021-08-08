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
    return ScaffoldMaster(Trns.sign_in.val,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        body: Obx(
          () => LoadingOverlay(
            opacity: 0.0,
            isLoading: controller.isLoading.value,
            child: Container(
                child: Column(children: [
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginButton(
                          Trns.sign_in_with_google.val,
                          icon: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                            size: 24.0,
                          ),
                          onClick: () {
                            controller.signInWithGoogle();
                          },
                        ),
                        LoginButton(
                          Trns.sign_in_with_facebook.val,
                          icon: Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                            size: 24.0,
                          ),
                          onClick: () {
                            controller.signInWithFacebook();
                          },
                        ),
                        SizedBox(height: 4.h),
                        Text("OR"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: CarouselSlider(
                      carouselController: controller.loginSliderController,
                      options: CarouselOptions(
                          height: 60.h,
                          viewportFraction: 1,
                          initialPage: initialPage!,
                          scrollPhysics: NeverScrollableScrollPhysics()),
                      items: [
                        FxLoginSlider(),
                        FxVerifyEmailSlider(),
                        FxForgotPasswordSlider()
                      ],
                    ),
                  ))
            ])),
          ),
        ));
  }
}
