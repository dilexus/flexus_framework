import 'package:focus_detector/focus_detector.dart';

import '../../imports.dart';

abstract class ScreenFragment<T> extends GetView<T>  {
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
  }

  void onStop() {}

  void onForeGround() {}

  void onBackGround() {}

  void onPause() {}

  void onResume() {}

}
