// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexus_framework/flexus_framework.dart';

import '../../../../consts/login_sliders.dart';
import '../../imports.dart';
import '../../services/auth_service.dart';
import '../login/login_screen.dart';

class FxSplashController extends GetxController {
  _startTimer() {
    new Future.delayed(Duration(seconds: Util.to.getConfig("splash_timer_seconds")), () async {
      FirebaseAuth.instance.currentUser?.reload();
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Util.to.setAuthUserDetails(AuthService.to.authUser.value, user);
        if (user.emailVerified) {
          AuthService.to.afterLogin().then((value) => Get.off(() => Util.to.getHomeScreen()));
          Util.to.logger().i("User found, going to home screen");
          Util.to.logger().d(user);
        } else {
          await user.sendEmailVerification();
          Get.off(() => FxLoginScreen(LoginSliders.verify_email));
          Util.to.logger().i("User found, email is not verified");
          Util.to.logger().d(user);
        }
      } else {
        Get.off(() => FxLoginScreen(LoginSliders.login));
        Util.to.logger().i("User not found, going to login screen");
      }
    });
  }

  navigateOff() {
    Get.off(() => FxLoginScreen(LoginSliders.login));
  }

  init() async {
    await FlexusController.to.init?.splashScreenInit();
    Util.to.logger().i("Splash Screen Loaded.");
    _startTimer();
  }
}
