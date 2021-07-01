import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../imports.dart';

class TextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? name;
  final String? label;
  final String? initialValue;
  final IconData? icon;
  final bool? obscureText;
  final bool enabled;
  final FormFieldValidator<String>? validator;

  const TextInput(
      {Key? key,
      this.controller,
      this.name,
      this.label,
      this.initialValue,
      this.icon,
      this.enabled = true,
      this.obscureText,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: FormBuilderTextField(
        controller: controller,
        name: name!,
        initialValue: initialValue,
        enabled: enabled,
        decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.all(16),
            border: new OutlineInputBorder(borderSide: new BorderSide()),
            prefixIcon: Icon(
              icon,
              color: enabled ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
            )),
        validator: validator,
        obscureText: obscureText!,
      ),
    );
  }
}
