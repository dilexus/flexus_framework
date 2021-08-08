import 'package:flexus_framework/imports.dart';

class ScaffoldMaster extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? drawer;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? textColor;
  ScaffoldMaster(this.title,
      {this.drawer,
      this.backgroundColor,
      this.textColor,
      this.leading,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: leading,
              title: Text(title),
              backwardsCompatibility: false,
              backgroundColor: backgroundColor ??
                  Theme.of(Get.context!).appBarTheme.backgroundColor,
              foregroundColor: textColor ??
                  Theme.of(Get.context!).appBarTheme.foregroundColor),
          drawer: drawer,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: body,
          )),
    );
  }
}
