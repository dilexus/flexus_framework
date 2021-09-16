// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../consts/login_sliders.dart';
import '../../../../flexus_framework.dart';
import '../../../../screens/front/front_screen.dart';
import '../../../../screens/log_in/log_in_screen.dart';
import '../../imports.dart';
import '../../services/auth_service.dart';
import '../front/front_screen.dart';

class FxSplashController extends GetxController {
  _startTimer() {
    Future.delayed(Duration(seconds: Util.to.getConfig("splashTimerSeconds")),
        () async {
      FirebaseAuth.instance.currentUser?.reload();
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Util.to.setAuthUserDetails(AuthService.to.authUser.value, user);
        if (user.emailVerified) {
          AuthService.to
              .afterLogin()
              .then((value) => Get.offAll(() => Util.to.getHomeScreen()));
          Util.to.logger().i("User found, going to home screen");
          Util.to.logger().d(user);
        } else {
          await user.sendEmailVerification();
          Get.off(() => const FxLoginScreen(LoginSliders.verifyEmail));
          Util.to.logger().i("User found, email is not verified");
          Util.to.logger().d(user);
        }
      } else {
        Get.off(() => const FxFrontScreen());
        Util.to.logger().i("User not found, going to front screen");
      }
    });
  }

  navigateOff() {
    Get.off(() => const FxFrontScreen());
  }

  init() async {
    await FlexusController.to.init?.splashScreenInit();
    Util.to.logger().i("Splash Screen Loaded.");
    _startTimer();
  }
}
