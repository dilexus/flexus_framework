// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import '../../../imports.dart';
import 'splash_controller.dart';

class FxSplashScreen extends ScreenMaster<FxSplashController> {
  const FxSplashScreen({Key? key}) : super(key: key);

  @override
  Widget create() {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo_1024.png",
          width: 200,
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
