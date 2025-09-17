import 'package:flutter/material.dart';

class RowFields extends StatelessWidget {
  final Widget firstField;
  final Widget lastField;

  const RowFields({
    super.key,
    required this.firstField,
    required this.lastField,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: firstField),
        const SizedBox(width: 10),
        Expanded(child: lastField),
      ],
    );
  }
}