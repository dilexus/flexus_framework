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
- Lint: `flutter analyze` (passes; only pre-existing `info`-level deprecation/duplicate-import lints).
- Test: `flutter test` (the only test, `test/flexus_framework_test.dart`, has an empty `main()`, so
  it reports "No tests ran" but the harness compiles and runs).

### Android / iOS app builds — KNOWN BROKEN at the dependency level (not an env issue)
This package cannot currently be compiled into an app for **any** target (Android, iOS, or web)
because of its pinned, pre-Dart-2.15 dependencies:
- `network_to_file_image 3.1.0`'s `_MockHttpClient implements HttpClient` is missing
  `HttpClient.keyLog` (added in Dart 2.15) and `connectionFactory` (added in Dart 2.18).
  The fix is only in `network_to_file_image 4.x`, which is **outside** this package's `^3.1.0`
  constraint. So it needs Dart `<= 2.14`.
- The locked `firebase_*` plugins (e.g. `firebase_core`, `firebase_auth 3.3.6`) reference APIs
  (`FirebaseAppPlatform.verifyExtends`, `RecaptchaVerifier(... auth:)`) that newer
  platform-interface packages no longer provide.

Because the package's other dependencies require `flutter >= 2.10` (Dart `>= 2.16`) while
`network_to_file_image 3.1.0` requires Dart `<= 2.14`, **there is no single Flutter version that
both resolves (`pub get`) and compiles**. `flutter build apk` runs the full Gradle pipeline
successfully and only fails at the Dart `kernel_snapshot` step with the errors above. To actually
ship an app you must bump `network_to_file_image` to `^4` and the `firebase_*` plugins in
`pubspec.yaml` (and adapt the code) — out of scope for environment setup.

iOS builds additionally **cannot run on Linux at all**: `flutter build ios` is not even a
registered subcommand here (only `aar/apk/appbundle/bundle/web` are). iOS requires macOS + Xcode.
