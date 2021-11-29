import 'package:flutter/cupertino.dart';

import '../../../../imports.dart';

class ScaffoldMaster extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? drawer;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? textColor;
  final AppBar? appBar;
  final List<Widget>? persistentFooterButtons;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColorOfScaffold;
  final Widget? bottomSheet;
  final Widget? bottomNavigationBar;
  final List<Widget>? actions;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  const ScaffoldMaster(this.title,
      {this.drawer,
      this.backgroundColor,
      this.textColor,
      this.leading,
      this.appBar,
      this.persistentFooterButtons,
      this.floatingActionButton,
      this.floatingActionButtonAnimator,
      this.floatingActionButtonLocation,
      this.resizeToAvoidBottomInset,
      this.backgroundColorOfScaffold,
      this.bottomSheet,
      this.bottomNavigationBar,
      this.actions,
      this.extendBody = false,
      this.extendBodyBehindAppBar = false,
      required this.body,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appBar ??
              AppBar(
                  leading: leading,
                  title: Text(title),
                  actions: actions,
                  backgroundColor: backgroundColor ??
                      Theme.of(Get.context!).appBarTheme.backgroundColor,
                  foregroundColor: textColor ??
                      Theme.of(Get.context!).appBarTheme.foregroundColor),
          drawer: drawer,
          floatingActionButton: floatingActionButton,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          floatingActionButtonLocation: floatingActionButtonLocation,
          bottomSheet: bottomSheet,
          bottomNavigationBar: bottomNavigationBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          backgroundColor: backgroundColorOfScaffold,
          persistentFooterButtons: persistentFooterButtons,
          body: body),
    );
  }
}
