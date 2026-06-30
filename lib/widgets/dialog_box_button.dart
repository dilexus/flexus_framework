import '../../imports.dart';

class DialogBoxButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const DialogBoxButton(this.buttonText, this.onPressed, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 48,
        minWidth: 100,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.theme.colorScheme.primary,
          foregroundColor: Get.theme.colorScheme.onPrimary,
          elevation: 1,
        ),
        child: Text(
          buttonText,
        ),
      ),
    );
  }
}
