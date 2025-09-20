import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class MyMedicationsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MyMedicationsPage());

  const MyMedicationsPage({super.key});

  @override
  State<MyMedicationsPage> createState() => _MyMedicationsPageState();
}

class _MyMedicationsPageState extends State<MyMedicationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Medications'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
      ),
      body: const Center(
        child: Text('My Medications'),
      ),
    );
  }
}
