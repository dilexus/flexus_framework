// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../widgets/dialog_box_button.dart';
import 'enums/build.dart';
import 'imports.dart';
import 'models/auth_user.dart';

class Util extends GetxController {
  static Util get to => Get.find();

  var _logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: false,
  ));

  Logger logger() {
    return _logger;
  }

  getConfig(String configName) {
    return FlavorConfig.instance!.variables![configName];
  }

  Widget getHomeScreen() {
    return Util.to.getConfig("home_screen");
  }

  setAuthUserDetails(AuthUser authUser, User user) {
    authUser.uuid = user.uid;
    authUser.name = user.displayName;
    authUser.email = user.email;
    if (user.photoURL == null) {
      authUser.profilePicture = user.providerData[0].photoURL;
    } else {
      authUser.profilePicture = user.photoURL;
    }

    authUser.isEmailVerified = user.emailVerified;
    switch (user.providerData[0].providerId) {
      case 'facebook.com':
        authUser.authType = AuthType.facebook;
        break;
      case 'google.com':
        authUser.authType = AuthType.google;
        break;
      case 'apple.com':
        authUser.authType = AuthType.apple;
        break;
      default:
        authUser.authType = AuthType.email;
    }
  }

  String getInitials({required String string, required int limitTo}) {
    var buffer = StringBuffer();
    var split = string.split(' ');
    if (limitTo > split.length) {
      limitTo = split.length;
    }
    for (var i = 0; i < limitTo; i++) {
      buffer.write(split[i][0]);
    }

    return buffer.toString();
  }

  Widget getCircularAvatar(String? profilePicture, String? name, BuildContext? context,
      {File? imageFile}) {
    if (imageFile != null && imageFile.path != "") {
      return CircleAvatar(
        backgroundImage: NetworkToFileImage(url: profilePicture, file: imageFile),
        radius: 50,
        backgroundColor: Colors.white,
      );
    } else if (profilePicture != null) {
      return CircleAvatar(
        backgroundImage: NetworkToFileImage(url: profilePicture),
        radius: 50,
        backgroundColor: Colors.white,
      );
    } else {
      return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        child: Text(
          Util.to.getInitials(string: name!, limitTo: 2),
          style: TextStyle(fontSize: 30, color: Theme.of(context!).primaryColor),
        ),
      );
    }
  }

  void showErrorSnackBar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
  }

  Map<String, Map<String, String>> getTranslations(
      Map<String, Map<String, String>> map1, Map<String, Map<String, String>> map2) {
    map1.forEach((c, o) => map1[c]!.forEach((k, v) => map2[c]?.putIfAbsent(k, () => v)));
    return map2;
  }

  // Dialog Boxes

  void showOKDialog(
      {required String message,
      required String title,
      String? textOK,
      VoidCallback? onOKPressed,
      Widget? content,
      bool barrierDismissible = false}) {
    Get.defaultDialog(
        title: title,
        middleText: message,
        barrierDismissible: barrierDismissible,
        content: content,
        confirm: DialogBoxButton(textOK ?? Trns.ok.val, onOKPressed ?? () => Get.back()),
        radius: 8);
  }

  void showYesNoDialog(
      {required String message,
      required String title,
      String? textYes,
      String? textNo,
      VoidCallback? onYesPressed,
      VoidCallback? onNoPressed,
      Widget? content,
      bool barrierDismissible = false}) {
    Get.defaultDialog(
        title: title,
        middleText: message,
        content: content,
        barrierDismissible: barrierDismissible,
        confirm: DialogBoxButton(textYes ?? Trns.yes.val, onYesPressed ?? () => Get.back()),
        cancel: DialogBoxButton(textNo ?? Trns.no.val, onNoPressed ?? () => Get.back()),
        radius: 8);
  }

  void showYesNoCustomDialog(
      {required String message,
      required String title,
      String? textYes,
      String? textNo,
      String? textCustom,
      VoidCallback? onYesPressed,
      VoidCallback? onNoPressed,
      VoidCallback? onCustomPressed,
      Widget? content,
      bool barrierDismissible = false}) {
    Get.defaultDialog(
        title: title,
        middleText: message,
        content: content,
        barrierDismissible: barrierDismissible,
        confirm: DialogBoxButton(textYes ?? Trns.yes.val, onYesPressed ?? () => Get.back()),
        cancel: DialogBoxButton(textNo ?? Trns.no.val, onNoPressed ?? () => Get.back()),
        custom: DialogBoxButton(textCustom ?? Trns.ok.val, onCustomPressed ?? () => Get.back()),
        radius: 8);
  }

  Future<File> getFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String pathName = path.join(dir.path, filename);
    return File(pathName);
  }

  Build getBuild() {
    switch (FlavorConfig.instance!.name) {
      case "Internal":
        return Build.internal;
      case "Alpha":
        return Build.alpha;
      case "Alpha":
        return Build.beta;
      default:
        return Build.prod;
    }
  }
}
