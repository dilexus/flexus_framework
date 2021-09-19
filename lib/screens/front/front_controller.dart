// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../consts/login_sliders.dart';
import '../../flexus_framework.dart';
import '../../imports.dart';
import '../../services/auth_service.dart';

class FxFrontController extends GetxController {
  CarouselController sliderController = CarouselController();
  var isLoading = false.obs;
  var currentSlider = 0.obs;
  final CarouselController loginSliderController = CarouselController();

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    try {
      UserCredential userCredential;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        Util.to.setAuthUserDetails(AuthService.to.authUser.value, user);
        isLoading.value = false;
        AuthService.to
            .afterLogin()
            .then((value) => Get.offAll(() => Util.to.getHomeScreen()));
      }
    } catch (e) {
      Util.to.logger().e(e);
      isLoading.value = false;
      Get.snackbar(
          FlexusController.to.title.value, Trns.errorGoogleSignInFailed.val,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

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
              .then((value) => Get.offAll(() => Util.to.getHomeScreen()));
        } else {
          await user.sendEmailVerification();
          isLoading.value = false;
          sliderController.jumpToPage(LoginSliders.verifyEmail);
        }
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      _handleError(e);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(FlexusController.to.title.value, Trns.errorSignUpFailure.val,
          snackPosition: SnackPosition.BOTTOM);
      Util.to.logger().e(e);
    }
  }

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
                .then((value) => Get.offAll(() => Util.to.getHomeScreen()));
          } else {
            await user.sendEmailVerification();
            sliderController.jumpToPage(LoginSliders.verifyEmail);
          }
        });
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      _handleError(e);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(FlexusController.to.title.value, Trns.errorSignUpFailure.val,
          snackPosition: SnackPosition.BOTTOM);
      Util.to.logger().e(e);
    }
  }

  Future<void> signInWithFacebook() async {
    isLoading.value = true;
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.success:
          AuthCredential credential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          User? user =
              (await FirebaseAuth.instance.signInWithCredential(credential))
                  .user;
          Util.to.logger().i(user);
          if (user != null) {
            Util.to.setAuthUserDetails(AuthService.to.authUser.value, user);
            isLoading.value = false;
            if (user.emailVerified) {
              AuthService.to.isEmailVerified.value = true;
              AuthService.to
                  .afterLogin()
                  .then((value) => Get.offAll(() => Util.to.getHomeScreen()));
            } else {
              await user.sendEmailVerification();
              sliderController.jumpToPage(LoginSliders.verifyEmail);
            }
          }
          break;
        case LoginStatus.cancelled:
          Util.to.logger().e(result.message);
          isLoading.value = false;
          Get.snackbar(FlexusController.to.title.value,
              Trns.errorFacebookSignInCanceled.val,
              snackPosition: SnackPosition.BOTTOM);
          break;
        case LoginStatus.failed:
          Util.to.logger().e(result.message);
          isLoading.value = false;
          Get.snackbar(FlexusController.to.title.value,
              Trns.errorFacebookSignInFailed.val,
              snackPosition: SnackPosition.BOTTOM);
          break;
        default:
      }
    } on FirebaseAuthException catch (e) {
      _handleError(e);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(FlexusController.to.title.value, Trns.errorSignUpFailure.val,
          snackPosition: SnackPosition.BOTTOM);
      Util.to.logger().e(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar(FlexusController.to.title.value, Trns.resetPasswordSent.val,
          snackPosition: SnackPosition.BOTTOM);
      sliderController.jumpToPage(LoginSliders.login);
    } catch (e) {
      Util.to.logger().e(e);
      Get.snackbar(
          FlexusController.to.title.value, Trns.errorResetPasswordFailed.val,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _handleError(FirebaseAuthException e) {
    switch (e.code) {
      case "user-not-found":
        Util.to.showErrorSnackBar(
            FlexusController.to.title.value, Trns.errorNoUserFound.val);
        break;
      case "wrong-password":
        Util.to.showErrorSnackBar(
            FlexusController.to.title.value, Trns.errorWrongPassword.val);
        break;
      case "weak-password":
        Util.to.showErrorSnackBar(
            FlexusController.to.title.value, Trns.errorWeakPassword.val);
        break;
      case "email-already-in-use":
        Util.to.showErrorSnackBar(
            FlexusController.to.title.value, Trns.errorAccountAlreadyExist.val);
        break;
      case "account-exists-with-different-credential":
        Util.to.showErrorSnackBar(FlexusController.to.title.value,
            Trns.errorAccountExistWithSameEmail.val);
        break;
      default:
        Util.to.showErrorSnackBar(
            FlexusController.to.title.value, Trns.errorSignInFailure.val);
    }
  }
}
