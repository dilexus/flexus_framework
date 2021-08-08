// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../consts/login_sliders.dart';
import '../../../../imports.dart';
import '../../../../screens/sign_up/sign_up_screen.dart';
import '../../../../widgets/text_input.dart';
import '../log_in_controller.dart';
import '../widgets/login_slider_master.dart';

class FxLoginSlider extends GetView<FxLogInController> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FxLoginSliderMaster(
      title: Trns.sign_in.val,
      child: Theme(
        data: new ThemeData(
          primaryColor: Util.to.getConfig("primary_color"),
          accentColor: Util.to.getConfig("accent_color"),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Util.to.getConfig("primary_color"),
            ),
          ),
        ),
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
            SizedBox(height: 16),
            ConstrainedBox(
              constraints:
                  BoxConstraints.tightFor(width: Get.width, height: 48),
              child: ElevatedButton(
                child: Text(Trns.sign_in.val),
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
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Trns.dont_have_an_account.val),
                InkWell(
                    child: Text(
                      Trns.sign_up.val,
                      style: TextStyle(
                          color: Util.to.getConfig("primary_color"),
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Get.off(() => FxSignUpScreen());
                    }),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Trns.forgot_your_password.val),
                InkWell(
                    child: Text(
                      Trns.reset.val,
                      style: TextStyle(
                          color: Util.to.getConfig("primary_color"),
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      controller.loginSliderController
                          .jumpToPage(LoginSliders.forgot_password);
                    }),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
