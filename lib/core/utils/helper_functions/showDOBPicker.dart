import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showDOBPicker({
  required BuildContext context,
  required Function(DateTime) onDateSelected,
  DateTime? initialDate,
}) async {
  showCupertinoModalPopup(
    context: context,
    builder: (_) => Container(
      height: 250,
      color: Colors.white,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        maximumDate: DateTime.now(),
        initialDateTime: initialDate ?? DateTime(2000),
        minimumYear: 1900,
        maximumYear: DateTime.now().year,
        onDateTimeChanged: onDateSelected,
      ),
    ),
  );
}
