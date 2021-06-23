library flexus_framework;

import 'package:flexus_framework/base_binding.dart';
import 'package:flexus_framework/base_init.dart';
import 'package:flexus_framework/imports.dart';

/// A Calculator.
class FlexusFramework {
  static void init(String title, BaseInit init) {
    BaseBindings().dependencies();
    FlexusController.to.title.value = title;
    FlexusController.to.init = init;
  }
}

class FlexusController extends GetxController {
  static FlexusController get to => Get.find();
  var title = "".obs;
  BaseInit? init;
}
