// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../consts/login_sliders.dart';
import '../../../../imports.dart';
import '../../../../services/auth_service.dart';
import '../log_in_controller.dart';
import '../widgets/login_slider_master.dart';

class FxVerifyEmailSlider extends GetView<FxLogInController> {
  final _formKey = GlobalKey<FormBuilderState>();

  FxVerifyEmailSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _callTimer();
    return Obx(
      () => FxLoginSliderMaster(
        title: Trns.verifyEmail.val,
        onBackPressed: AuthService.to.isEmailVerified.value
            ? null
            : () {
                controller.loginSliderController
                    .animateToPage(LoginSliders.login);
              },
        child: Theme(
          data: ThemeData().copyWith(
              colorScheme: ThemeData().colorScheme.copyWith(
                  primary: Util.to.getConfig("primaryColor"),
                  secondary: Util.to.getConfig("secondaryColor"))),
          child: FormBuilder(
            key: _formKey,
            child: Column(children: [
              AuthService.to.isEmailVerified.value
                  ? Text(Trns.emailAfterVerified.val,
                      textAlign: TextAlign.center)
                  : Text(Trns.emailIsBeingVerified.val,
                      textAlign: TextAlign.center),
              const SizedBox(height: 32),
              ConstrainedBox(
                constraints:
                    BoxConstraints.tightFor(width: Get.width, height: 48),
                child: ElevatedButton(
                  child: Text(Trns.next.val),
                  onPressed: AuthService.to.isEmailVerified.value
                      ? () {
                          AuthService.to.authUser.value.isEmailVerified = true;
                          AuthService.to.afterLogin().then((value) =>
                              Get.off(() => Util.to.getHomeScreen()));
                        }
                      : null,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _callTimer() {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      FirebaseAuth.instance.currentUser!.reload();
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (user.emailVerified) {
          AuthService.to.authUser.value.isEmailVerified = true;
          AuthService.to.isEmailVerified.value = true;
          timer.cancel();
        }
      }
    });
  }
}
