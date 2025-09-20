import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class MyTestsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MyTestsPage());

  const MyTestsPage({super.key});

  @override
  State<MyTestsPage> createState() => _MyTestsPageState();
}

class _MyTestsPageState extends State<MyTestsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tests'),
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
        child: Text('My Tests'),
      ),
    );
  }
}
