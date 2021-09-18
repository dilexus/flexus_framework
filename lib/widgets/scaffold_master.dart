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
  final List<Widget>? actions;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  const ScaffoldMaster(this.title,
      {this.drawer,
      this.backgroundColor,
      this.textColor,
      this.leading,
      this.appBar,
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
          body: body),
    );
  }
}
