import '../../imports.dart';

class DialogBoxButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  DialogBoxButton(this.buttonText, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: new BoxConstraints(
        minHeight: 48,
        minWidth: 100,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Theme.of(Get.context!).primaryColor,
          elevation: 0,
        ),
        child: Text(
          buttonText,
        ),
      ),
    );
  }
}
