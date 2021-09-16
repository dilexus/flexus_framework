import '../../imports.dart';

class FormFieldSeparator extends StatelessWidget {
  final String name;

  FormFieldSeparator(this.name);

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
