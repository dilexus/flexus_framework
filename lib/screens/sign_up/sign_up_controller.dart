// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import '../../flexus_framework.dart';
import '../../imports.dart';
import '../../services/auth_service.dart';

class FxSignUpController extends GetxController {
  var isLoading = false.obs;

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String? name) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user!;
      await user.updateDisplayName(name);
      user = FirebaseAuth.instance.currentUser!
        ..reload().then((value) async {
          Util.to.logger().i("Use sign up was successful with email");
          Util.to.logger().i(user);
          Util.to.setAuthUserDetails(AuthService.to.authUser.value, user);
          isLoading.value = false;
          if (user.emailVerified) {
            AuthService.to.isEmailVerified.value = true;
            AuthService.to
                .afterLogin()
                .then((value) => Get.off(() => Util.to.getHomeScreen()));
          } else {
            await user.sendEmailVerification();
            //TODO Call Email Verification
            // sliderController.jumpToPage(LoginSliders.verify_email);
          }
        });
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
