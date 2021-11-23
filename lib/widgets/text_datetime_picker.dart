import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../imports.dart';

class TextDateTimePicker extends StatelessWidget {
  final String? name;
  final String? label;
  final IconData? icon;
  final DateTime? initialValue;
  final InputType? inputType;
  final bool enabled;
  final FormFieldValidator<DateTime>? validator;

  const TextDateTimePicker(
      {Key? key,
      this.name,
      this.label,
      this.icon,
      this.initialValue,
      this.inputType,
      this.enabled = true,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: FormBuilderDateTimePicker(
        initialDatePickerMode: DatePickerMode.year,
        name: name!,
        inputType: inputType!,
        format: DateFormat("dd/MM/yyyy"),
        style: TextStyle(
            color: enabled
                ? Get.theme.colorScheme.onBackground
                : Theme.of(context).disabledColor),
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
            prefixIcon: Icon(
              icon,
              color: enabled
                  ? Get.theme.colorScheme.onBackground
                  : Get.theme.disabledColor,
            )),
        initialValue: initialValue,
        validator: validator,
        enabled: enabled,
      ),
    );
  }
}
