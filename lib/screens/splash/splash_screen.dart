// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import '../../../imports.dart';
import 'splash_controller.dart';

class FxSplashScreen extends ScreenMaster<FxSplashController> {
  @override
  Widget create() {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image.asset(
            "assets/logos/logo_1024.png",
            width: 200,
          ),
        ),
      ),
    );
  }

  @override
  void onStart() {
    controller.init();
    super.onStart();
  }
}
