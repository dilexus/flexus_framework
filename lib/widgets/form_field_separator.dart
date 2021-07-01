import '../../imports.dart';

class FormFieldSeparator extends StatelessWidget {
  final String name;

  FormFieldSeparator(this.name);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
      ],
    );
  }
}
