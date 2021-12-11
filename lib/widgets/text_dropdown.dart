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
                  ? Get.theme.colorScheme.onBackground
                  : Get.theme.disabledColor,
            ),
            labelText: label,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Get.theme.colorScheme.secondary),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Get.theme.colorScheme.onBackground),
            ),
            border: const OutlineInputBorder(borderSide: BorderSide()),
            contentPadding: const EdgeInsets.all(16),
            prefixIcon: Icon(icon,
                color: enabled
                    ? Get.theme.colorScheme.onBackground
                    : Get.theme.disabledColor)),
        allowClear: allowClear,
        hint: Text(
          hint!,
          style: TextStyle(color: Get.theme.colorScheme.onBackground),
        ),
        style: TextStyle(
          color: Get.theme.colorScheme.onBackground,
        ),
        validator: validator,
        enabled: enabled,
        dropdownColor: Get.theme.colorScheme.background,
        items: items!
            .map((val) => DropdownMenuItem(
                  value: val,
                  child: Text(
                    Trns.values
                        .firstWhereOrNull((f) => f.toString() == "Trns.$val")
                        .val,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
