// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'imports.dart';

class BaseTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          Trns.sign_in.name: 'Sign In',
          Trns.sign_up.name: 'Sign Up',
          Trns.name.name: 'Name',
          Trns.username.name: 'Username',
          Trns.email.name: 'Email',
          Trns.password.name: 'Password',
          Trns.confirm_password.name: "Confirm Password",
          Trns.dont_have_an_account.name: "Don't have an account? ",
          Trns.forgot_your_password.name: "Forgot your password? ",
          Trns.reset.name: "Reset",
          Trns.or_sign_in_with.name: "or sign in with",
          Trns.already_have_an_account.name: "Already have an account? ",
          Trns.email_is_being_verified.name:
              "Your email is being verified. Please click on the link which is sent to your email and click on Next button once you do so.",
          Trns.email_after_verified.name:
              "Thank you for verifying your email. Please click on Next to go in to the app.",
          Trns.verify_email.name: "Verify Email",
          Trns.verify.name: "Verify",
          Trns.next.name: "Next",
          Trns.logout.name: "Logout",
          Trns.reset_password.name: "Reset Password",
          Trns.welcome_name.name: "Welcome @name!",
          Trns.profile.name: "My Profile",
          Trns.update_profile.name: "Update Profile",
          Trns.account.name: "Account",
          Trns.security.name: "Security",
          Trns.male.name: "Male",
          Trns.female.name: "Female",
          Trns.warning_passwords_not_matching.name: "Password length must be 8 characters long",
          Trns.warning_minimum_password_length.name:
              "Password and confirm password is not matching",
          Trns.select_the_gender.name: "Select the gender",
          Trns.gender.name: "Gender",
          Trns.date_of_birth.name: "Date of Birth",
          Trns.account_details.name: "Account Details",
          Trns.ok.name: "OK",
          Trns.cancel.name: "Cancel",
          Trns.yes.name: "Yes",
          Trns.no.name: "No",
          Trns.reset_password_sent.name: "Reset password email sent to your email inbox",
          Trns.logout_confirmation.name: "Are you sure you want to logout?",
          Trns.error_no_user_found.name: "No user found for that email.",
          Trns.error_wrong_password.name: "Wrong password provided for that user.",
          Trns.error_weak_password.name: "The password provided is too weak.",
          Trns.error_account_already_exist.name: "The account already exists for that email.",
          Trns.error_account_exist_with_same_email.name:
              "An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.",
          Trns.error_sign_in_failure.name: "Sign in failure",
          Trns.error_sign_up_failure.name: "Sign in failure",
          Trns.error_reset_password_failed.name: "Failed to reset the password",
          Trns.error_google_sign_in_failed.name: "Failed to sign in with Google.",
          Trns.error_facebook_sign_in_failed.name: "Failed to sign in with Facebook.",
          Trns.error_facebook_sign_in_canceled.name: "Failed to sign in with Facebook.",
        },
        'de': {
          'hello': 'Hallo Welt',
        }
      };
}

enum Trns {
  translation,
  sign_in,
  sign_up,
  name,
  username,
  email,
  password,
  confirm_password,
  dont_have_an_account,
  forgot_your_password,
  reset,
  or_sign_in_with,
  already_have_an_account,
  email_is_being_verified,
  email_after_verified,
  verify_email,
  verify,
  next,
  logout,
  reset_password,
  welcome_name,
  profile,
  update_profile,
  account,
  security,
  male,
  female,
  warning_passwords_not_matching,
  warning_minimum_password_length,
  select_the_gender,
  gender,
  date_of_birth,
  account_details,
  ok,
  cancel,
  yes,
  no,
  reset_password_sent,
  logout_confirmation,
  error_no_user_found,
  error_wrong_password,
  error_weak_password,
  error_account_already_exist,
  error_account_exist_with_same_email,
  error_sign_in_failure,
  error_sign_up_failure,
  error_reset_password_failed,
  error_google_sign_in_failed,
  error_facebook_sign_in_failed,
  error_facebook_sign_in_canceled
}

extension ExtTr on Trns? {
  String get val {
    return this.toString().tr;
  }

  String? trParams([Map<String, String> params = const {}]) {
    return this.toString().trParams(params);
  }

  String get name {
    return this.toString();
  }
}
