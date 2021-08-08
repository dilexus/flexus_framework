import 'package:flexus_framework/imports.dart';

class ScaffoldMaster extends StatelessWidget {
  final String title;
  final Widget child;
  ScaffoldMaster(this.title, {required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              title: Text(title),
              backwardsCompatibility: false,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          )),
    );
  }
}
