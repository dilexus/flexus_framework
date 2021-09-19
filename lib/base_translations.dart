// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'imports.dart';

class BaseTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          Trns.signIn.name: 'Sign In',
          Trns.signInWithGoogle.name: 'Sign in with Google',
          Trns.signInWithFacebook.name: 'Sign in with Facebook',
          Trns.signInWithApple.name: 'Sign in with Apple',
          Trns.signUpWithGoogle.name: 'Sign up with Google',
          Trns.signUpWithFacebook.name: 'Sign up with Facebook',
          Trns.signUpWithApple.name: 'Sign up with Apple',
          Trns.signIn.name: 'Sign In',
          Trns.signUp.name: 'Sign Up',
          Trns.name.name: 'Name',
          Trns.username.name: 'Username',
          Trns.email.name: 'Email',
          Trns.password.name: 'Password',
          Trns.confirmPassword.name: "Confirm Password",
          Trns.dontHaveAnAccount.name: "Don't have an account? ",
          Trns.forgotYourPassword.name: "Forgot your password? ",
          Trns.reset.name: "Reset",
          Trns.orSignInWith.name: "or front in with",
          Trns.alreadyHaveAnAccount.name: "Already have an account? ",
          Trns.emailIsBeingVerified.name:
              "Your email is being verified. Please click on the link which is sent to your email and click on Next button once you do so.",
          Trns.emailAfterVerified.name:
              "Thank you for verifying your email. Please click on Next to go in to the app.",
          Trns.verifyEmail.name: "Verify Email",
          Trns.verify.name: "Verify",
          Trns.next.name: "Next",
          Trns.logout.name: "Sign Out",
          Trns.resetPassword.name: "Reset Password",
          Trns.welcomeName.name: "Welcome @name!",
          Trns.profile.name: "My Profile",
          Trns.updateProfile.name: "Update Profile",
          Trns.account.name: "Account",
          Trns.security.name: "Security",
          Trns.male.name: "Male",
          Trns.female.name: "Female",
          Trns.warningPasswordsNotMatching.name:
              "Password length must be 8 characters long",
          Trns.warningMinimumPasswordLength.name:
              "Password and confirm password is not matching",
          Trns.selectTheGender.name: "Select the gender",
          Trns.gender.name: "Gender",
          Trns.dateOfBirth.name: "Date of Birth",
          Trns.accountDetails.name: "Account Details",
          Trns.ok.name: "OK",
          Trns.cancel.name: "Cancel",
          Trns.yes.name: "Yes",
          Trns.no.name: "No",
          Trns.resetPasswordSent.name:
              "Reset password email sent to your email inbox",
          Trns.logoutConfirmation.name: "Are you sure you want to sign out?",
          Trns.errorNoUserFound.name: "No user found for that email.",
          Trns.errorWrongPassword.name:
              "Wrong password provided for that user.",
          Trns.errorWeakPassword.name: "The password provided is too weak.",
          Trns.errorAccountAlreadyExist.name:
              "The account already exists for that email.",
          Trns.errorAccountExistWithSameEmail.name:
              "An account already exists with the same email address but different front-in credentials. Sign in in using a provider associated with this email address.",
          Trns.errorSignInFailure.name: "Sign in in failure",
          Trns.errorSignUpFailure.name: "Sign in in failure",
          Trns.errorResetPasswordFailed.name: "Failed to reset the password",
          Trns.errorGoogleSignInFailed.name: "Failed to front in with Google.",
          Trns.errorFacebookSignInFailed.name:
              "Failed to front in with Facebook.",
          Trns.errorFacebookSignInCanceled.name:
              "Failed to front in with Facebook.",
          Trns.errorTooManyRequests.name:
              "Too many requests to verify the email. Please try again in a while",
        },
        'de': {
          'hello': 'Hallo Welt',
        }
      };
}

enum Trns {
  translation,
  signIn,
  signInWithGoogle,
  signInWithFacebook,
  signInWithApple,
  signUp,
  signUpWithGoogle,
  signUpWithFacebook,
  signUpWithApple,
  name,
  username,
  email,
  password,
  confirmPassword,
  dontHaveAnAccount,
  forgotYourPassword,
  reset,
  orSignInWith,
  alreadyHaveAnAccount,
  emailIsBeingVerified,
  emailAfterVerified,
  verifyEmail,
  verify,
  next,
  logout,
  resetPassword,
  welcomeName,
  profile,
  updateProfile,
  account,
  security,
  male,
  female,
  warningPasswordsNotMatching,
  warningMinimumPasswordLength,
  selectTheGender,
  gender,
  dateOfBirth,
  accountDetails,
  ok,
  cancel,
  yes,
  no,
  resetPasswordSent,
  logoutConfirmation,
  errorNoUserFound,
  errorWrongPassword,
  errorWeakPassword,
  errorAccountAlreadyExist,
  errorAccountExistWithSameEmail,
  errorSignInFailure,
  errorSignUpFailure,
  errorResetPasswordFailed,
  errorGoogleSignInFailed,
  errorFacebookSignInFailed,
  errorFacebookSignInCanceled,
  errorTooManyRequests
}

extension ExtTr on Trns? {
  String get val {
    return toString().tr;
  }

  String? trParams([Map<String, String> params = const {}]) {
    return toString().trParams(params);
  }

  String get name {
    return toString();
  }
}
