import 'package:flutter/material.dart';
import 'package:vaccine_home/core/utils/widgets/custom_bottom_sheet.dart';

Future<void> showCustomBottomSheet({
  required BuildContext context,
  required List<String> items,
  required TextEditingController controller,
  required String title,
}) async {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return SafeArea(
        child: CustomBottomSheetContent(
          items: items,
          controller: controller,
          title: title,
          onItemSelected: (item) {
            controller.text = item;
            Navigator.pop(context);
          },
        ),
      );
    },
  );
}
