library flexus_framework;

import 'base_binding.dart';
import 'base_init.dart';
import 'imports.dart';
import 'screens/front/widgets/front_slider_item.dart';

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
  List<FxFrontSliderItem> frontSliderItems = [];
  BaseInit? init;
}
