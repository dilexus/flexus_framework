# AGENTS.md

## Cursor Cloud specific instructions

### What this repo is
`flexus_framework` is a **Flutter library/package** (`pubspec.yaml` → `project_type: package`),
not a standalone application. It has no `android/`, `ios/`, or `web/` runner directory and no
app `main()` — it is consumed by other Flutter apps. The normal development workflow is therefore
`flutter pub get` → `flutter analyze` → `flutter test`.

### Toolchain (already installed in the VM snapshot)
- **Flutter 3.7.12 / Dart 2.19.6** at `~/flutter` (on `PATH` via `~/.bashrc`). This is the newest
  stable Flutter whose Dart is `< 3.0.0`, which is required by `pubspec.yaml`
  (`sdk: ">=2.12.0 <3.0.0"`) and `pubspec.lock` (`dart: ">=2.14.0 <3.0.0"`, `flutter: ">=2.10.0-0"`).
  Do not upgrade to a Dart 3 Flutter — `pub get` will reject it.
- **Android SDK** at `~/android-sdk` (platform `android-33`, `build-tools;33.0.2`, `platform-tools`).
  `flutter config --android-sdk ~/android-sdk` is already set.
- **JDK 17** at `/usr/lib/jvm/java-17-openjdk-amd64` (exported as `JAVA_HOME` in `~/.bashrc`).
  JDK 17 is required: the Gradle wrapper that Flutter 3.7 generates does **not** support the VM's
  default JDK 21, so Android Gradle tasks fail under JDK 21.
- `~/.bashrc` exports `JAVA_HOME`, `ANDROID_SDK_ROOT`, `ANDROID_HOME` and adds Flutter + Android
  tools to `PATH`. Non-login/non-interactive shells may not source it, so when scripting use the
  absolute binary path `~/flutter/bin/flutter` if `flutter` is not found.

### Lint / test (these work)
- Lint: `flutter analyze` (clean — no issues).
- Test: `flutter test` (the only test, `test/flexus_framework_test.dart`, has an empty `main()`, so
  it reports "No tests ran" but the harness compiles and runs).

### Building this package into an app
`flexus_framework` is a library, so it is built/run through a host app (e.g. a small example app
with a path dependency on this repo). The dependencies were upgraded to versions that compile under
Flutter 3.7.12 / Dart 2.19 (`network_to_file_image 4.x`, `firebase_* 4.x/10.x/11.x`,
`image_cropper 4.x`, `flutter_form_builder`/`form_builder_validators 8.x`, `carousel_slider 5.x`,
etc.). `sizer` is intentionally kept at `2.0.15`: 3.x changes `DeviceType` to OS-based values
(no `mobile`/`tablet`) and re-exports `ScreenType`, which clashes with `get`.

Known build caveats for a consuming/host app (not the package itself):
- The host app's `android/app/build.gradle` must set `minSdkVersion 21` (cloud_firestore requires
  `>= 19`); the Flutter default (`flutter.minSdkVersion`) is too low.
- After changing `package_info_plus` major versions, run `flutter clean` in the host app before a
  web build, otherwise a stale `web_plugin_registrant.dart` references the removed
  `package_info_plus_web` package.

### iOS
iOS builds **cannot run on Linux**: `flutter build ios` is not a registered subcommand here
(only `aar/apk/appbundle/bundle/web` are). iOS requires macOS + Xcode.
