import 'package:flexus_framework/imports.dart';

class AppBarActionButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onPressed;
  const AppBarActionButton(
      {required this.title,
      required this.icon,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [icon, Text(title)],
        ),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(20.0, 20.0),
            side: null,
            elevation: 0,
            primary: Colors.transparent,
            padding: const EdgeInsets.only(left: 8.0, right: 8.0)),
        onPressed: onPressed,
      ),
    );
  }
}
