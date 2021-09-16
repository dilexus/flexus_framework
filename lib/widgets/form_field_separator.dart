import '../../imports.dart';

class FormFieldSeparator extends StatelessWidget {
  final String name;

  const FormFieldSeparator(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
      ],
    );
  }
}
