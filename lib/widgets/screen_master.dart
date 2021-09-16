// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:firebase_analytics/firebase_analytics.dart';

import '../flexus_framework.dart';
import '../imports.dart';
import 'screen_fragment.dart';

abstract class ScreenMaster<T> extends ScreenFragment<T> {
  const ScreenMaster({Key? key}) : super(key: key);

  @override
  void onStart() {
    super.onStart();
    if (FlexusController.to.enableAnalytics) {
      FirebaseAnalytics().setCurrentScreen(screenName: runtimeType.toString());
    }
  }
}
