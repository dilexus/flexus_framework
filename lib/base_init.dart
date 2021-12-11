import 'enums/build.dart';

abstract class BaseInit {
  appInit() {}

  init(Build build) {}

  splashScreenInit();

  afterAuthentication();
}
