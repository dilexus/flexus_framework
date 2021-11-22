// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flexus_framework/screens/sign_up/sign_up_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../consts/login_sliders.dart';
import '../../../../imports.dart';
import '../../../../widgets/text_input.dart';
import '../log_in_screen.dart';
import '../widgets/login_slider_master.dart';

class FxSignUpSlider extends GetView<FxSignUpController> {
  final _formKey = GlobalKey<FormBuilderState>();
  FxSignUpSlider({Key? key}) : super(key: key);

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
                name: 'name',
                label: Trns.name.val,
                icon: Icons.person_outline,
                obscureText: false,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(Get.context!),
                  FormBuilderValidators.maxLength(Get.context!, 50),
                ])),
            TextInput(
                name: 'email',
                label: Trns.email.val,
                icon: Icons.email_outlined,
                obscureText: false,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(Get.context!),
                  FormBuilderValidators.email(Get.context!),
                  FormBuilderValidators.maxLength(Get.context!, 50),
                ])),
            TextInput(
                name: 'password',
                label: Trns.password.val,
                icon: Icons.vpn_key,
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(Get.context!),
                  FormBuilderValidators.maxLength(Get.context!, 50),
                  FormBuilderValidators.minLength(Get.context!, 8),
                ])),
            TextInput(
                name: 'confirm_password',
                label: Trns.confirmPassword.val,
                icon: Icons.vpn_key,
                obscureText: true,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(Get.context!),
                  FormBuilderValidators.maxLength(Get.context!, 50),
                  FormBuilderValidators.minLength(Get.context!, 8),
                  (val) {
                    if (_formKey.currentState!.fields['password']?.value !=
                        val) {
                      return Trns.warningPasswordsNotMatching.val;
                    }
                    return null;
                  }
                ])),
            const SizedBox(height: 16),
            SizedBox(
              width: 75.w,
              height: 48,
              child: ElevatedButton(
                child: Text(Trns.signUp.val),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    var name = _formKey.currentState!.fields['name']?.value;
                    var email = _formKey.currentState!.fields['email']?.value;
                    var password =
                        _formKey.currentState!.fields['password']?.value;
                    controller.signUpWithEmailAndPassword(
                        email, password, name);
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
                Text(Trns.alreadyHaveAnAccount.val),
                InkWell(
                    child: Text(
                      Trns.signIn.val,
                      style: TextStyle(
                          color: Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.off(() => const FxLoginScreen(LoginSliders.login));
                    }),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
