// Copyright 2021 Chatura Dilan Perera. All rights reserved.
// Use of this source code is governed by a MIT license

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';

import '../flexus_framework.dart';

abstract class ScreenMaster<T> extends GetView<T> {
  T get controller => GetInstance().find<T>(tag: tag);
  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: onResume,
      onFocusLost: onPause,
      onVisibilityGained: onStart,
      onVisibilityLost: onStop,
      onForegroundGained: onForeGround,
      onForegroundLost: onBackGround,
      child: create(),
    );
  }

  Widget create();

  void onStart() {
    if (FlexusController.to.enableAnalytics) {
      FirebaseAnalytics()
          .setCurrentScreen(screenName: this.runtimeType.toString());
    }
  }

  void onStop() {}

  void onForeGround() {}

  void onBackGround() {}

  void onPause() {}

  void onResume() {}
}
