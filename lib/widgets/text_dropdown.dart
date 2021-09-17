import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../imports.dart';

class TextDropdown extends StatelessWidget {
  final String? name;
  final String? label;
  final String? hint;
  final IconData? icon;
  final bool allowClear;
  final List<String>? items;
  final bool enabled;
  final String? initialValue;
  final FormFieldValidator<String>? validator;

  const TextDropdown(
      {Key? key,
      this.name,
      this.label,
      this.hint,
      this.icon,
      this.allowClear = false,
      this.items,
      this.enabled = true,
      this.validator,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: FormBuilderDropdown(
        name: name!,
        initialValue: initialValue,
        decoration: InputDecoration(
            labelStyle: TextStyle(
              color: enabled
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).disabledColor,
            ),
            labelText: label,
            contentPadding: const EdgeInsets.all(16),
            border: const OutlineInputBorder(borderSide: BorderSide()),
            prefixIcon: Icon(icon,
                color: enabled
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).disabledColor)),
        allowClear: allowClear,
        hint: Text(hint!),
        validator: validator,
        enabled: enabled,
        items: items!
            .map((val) => DropdownMenuItem(
                  value: val,
                  child: Text(Trns.values
                      .firstWhereOrNull((f) => f.toString() == "Trns.$val")
                      .val),
                ))
            .toList(),
      ),
    );
  }
}
