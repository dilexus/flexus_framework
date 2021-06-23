// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../consts/login_sliders.dart';
import '../../../../imports.dart';
import '../../../../widgets/text_input.dart';
import '../login_controller.dart';
import '../widgets/login_slider_master.dart';

class FxRegistrationSlider extends GetView<FxLoginController> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FxLoginSliderMaster(
        title: Trns.sign_up.val,
        onBackPressed: () {
          controller.sliderController.jumpToPage(LoginSliders.login);
        },
        child: Theme(
          data: new ThemeData(
            primaryColor: Util.to.getConfig("primary_color"),
            accentColor: Util.to.getConfig("accent_color"),
            hintColor: Util.to.getConfig("primary_color"),
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
                  name: 'name',
                  label: Trns.name.val,
                  icon: Icons.person_outline,
                  obscureText: false,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.maxLength(context, 50),
                  ])),
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
                    FormBuilderValidators.minLength(context, 8),
                  ])),
              TextInput(
                  name: 'confirm_password',
                  label: Trns.confirm_password.val,
                  icon: Icons.vpn_key,
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                    FormBuilderValidators.maxLength(context, 50),
                    FormBuilderValidators.minLength(context, 8),
                    (val) {
                      if (_formKey.currentState!.fields['password']?.value != val) {
                        return Trns.warning_passwords_not_matching.val;
                      }
                      return null;
                    }
                  ])),
              SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: Get.width, height: 48),
                child: ElevatedButton(
                  child: Text(Trns.sign_up.val),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var name = _formKey.currentState!.fields['name']?.value;
                      var email = _formKey.currentState!.fields['email']?.value;
                      var password = _formKey.currentState!.fields['password']?.value;
                      controller.signUpWithEmailAndPassword(email, password, name);
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
                  Text(Trns.already_have_an_account.val),
                  InkWell(
                      child: Text(
                        Trns.sign_in.val,
                        style: TextStyle(
                            color: Util.to.getConfig("primary_color"), fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        controller.sliderController.jumpToPage(LoginSliders.login);
                      }),
                ],
              ),
            ]),
          ),
        ));
  }
}
