import 'enums/build.dart';

abstract class BaseInit {
  init(Build build);

  splashScreenInit();

  afterAuthentication();
}
