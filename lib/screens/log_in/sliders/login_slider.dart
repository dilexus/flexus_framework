// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../consts/login_sliders.dart';
import '../../../../imports.dart';
import '../../../../screens/sign_up/sign_up_screen.dart';
import '../../../../widgets/text_input.dart';
import '../log_in_controller.dart';
import '../widgets/login_slider_master.dart';

class FxLoginSlider extends GetView<FxLogInController> {
  final _formKey = GlobalKey<FormBuilderState>();
  FxLoginSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FxLoginSliderMaster(
      title: Trns.signIn.val,
      child: Theme(
        data: ThemeData().copyWith(
            colorScheme: ThemeData().colorScheme.copyWith(
                primary: Get.theme.colorScheme.primary,
                secondary: Get.theme.colorScheme.secondary)),
        child: FormBuilder(
          key: _formKey,
          child: Column(children: [
            TextInput(
                name: 'email',
                label: Trns.email.val,
                icon: Icons.email_outlined,
                obscureText: false,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.email(context),
                  FormBuilderValidators.maxLength(context, 50),
                ])),
            TextInput(
                name: 'password',
                label: Trns.password.val,
                icon: Icons.vpn_key,
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.maxLength(context, 50),
                ])),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints:
                  BoxConstraints.tightFor(width: Get.width, height: 48),
              child: ElevatedButton(
                child: Text(Trns.signIn.val),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var email = _formKey.currentState!.fields['email']?.value;
                    var password =
                        _formKey.currentState!.fields['password']?.value;
                    controller.signInWithEmailAndPassword(email, password);
                  } else {
                    Util.to.logger().e("Validation Failed");
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Trns.dontHaveAnAccount.val),
                InkWell(
                    child: Text(
                      Trns.signUp.val,
                      style: TextStyle(
                          color: Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.off(() => const FxSignUpScreen(LoginSliders.login));
                    }),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Trns.forgotYourPassword.val),
                InkWell(
                    child: Text(
                      Trns.reset.val,
                      style: TextStyle(
                          color: Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      controller.loginSliderController
                          .jumpToPage(LoginSliders.forgotPassword);
                    }),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
