// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../flexus_framework.dart';
import '../../imports.dart';
import '../../services/auth_service.dart';

class FxLogInController extends GetxController {
  var isLoading = false.obs;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      Util.to.logger().i("Use sign in was successful with email");
      Util.to.logger().i(user);
      if (user != null) {
        Util.to.setAuthUserDetails(AuthService.to.authUser.value, user);
        if (user.emailVerified) {
          AuthService.to.isEmailVerified.value = true;
          isLoading.value = false;
          AuthService.to
              .afterLogin()
              .then((value) => Get.off(() => Util.to.getHomeScreen()));
        } else {
          await user.sendEmailVerification();
          isLoading.value = false;
          //TODO sliderController.jumpToPage(LoginSliders.verify_email);
        }
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Util.to.handleSignError(e);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
          FlexusController.to.title.value, Trns.error_sign_up_failure.val,
          snackPosition: SnackPosition.BOTTOM);
      Util.to.logger().e(e);
    }
  }
}
