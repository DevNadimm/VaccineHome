import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class MyConsultationsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MyConsultationsPage());

  const MyConsultationsPage({super.key});

  @override
  State<MyConsultationsPage> createState() => _MyConsultationsPageState();
}

class _MyConsultationsPageState extends State<MyConsultationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Consultations'),
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
        child: Text('My Consultations'),
      ),
    );
  }
}
