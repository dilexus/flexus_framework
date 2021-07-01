// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:get/get.dart';

import 'flexus_framework.dart';
import 'imports.dart';
import 'screens/login/login_controller.dart';
import 'screens/splash/splash_controller.dart';
import 'services/auth_service.dart';
import 'util.dart';

class BaseBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(FlexusController());
    Get.put(FxSplashController());
    Get.put(AuthService());
    Get.put(Util());
    Get.put(FxLoginController());
  }
}
