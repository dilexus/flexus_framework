import 'package:flexus_framework/screens/log_in/log_in_controller.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../imports.dart';
import '../../widgets/login_button.dart';
import '../../widgets/text_input.dart';

class FxLoginScreen extends ScreenMaster<FxLogInController> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget create() {
    return ScaffoldMaster(Trns.sign_up.val,
        child: Container(
            child: Column(children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginButton(
                      Trns.sign_up_with_google.val,
                      icon: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                        size: 24.0,
                      ),
                      onClick: () {},
                    ),
                    LoginButton(
                      Trns.sign_up_with_facebook.val,
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                      onClick: () {},
                    ),
                    SizedBox(height: 4.h),
                    Text("OR"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 32.0, right: 32.0),
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
                            ])),
                        SizedBox(height: 16),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: Get.width, height: 48),
                          child: ElevatedButton(
                            child: Text(Trns.sign_in.val),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                var email = _formKey
                                    .currentState!.fields['email']?.value;
                                var password = _formKey
                                    .currentState!.fields['password']?.value;
                                controller.signInWithEmailAndPassword(
                                    email, password);
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
                                  // TODO controller.sliderController
                                  //     .jumpToPage(LoginSliders.registration);
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
                                  // TODO controller.sliderController
                                  //     .jumpToPage(LoginSliders.forgot_password);
                                }),
                          ],
                        ),
                      ]),
                    ),
                  ),
                ),
              ))
        ])));
  }
}
