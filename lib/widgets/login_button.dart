import '../../imports.dart';

class LoginButton extends StatelessWidget {
  final String name;
  final VoidCallback onClick;
  final Icon icon;
  LoginButton(this.name, {required this.icon, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: SizedBox(
        width: 75.w,
        height: 48,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.0, color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Stack(
              children: [
                Align(alignment: Alignment.centerLeft, child: icon),
                Align(alignment: Alignment.center, child: Text(name)),
              ],
            ),
            onPressed: onClick),
      ),
    );
  }
}
