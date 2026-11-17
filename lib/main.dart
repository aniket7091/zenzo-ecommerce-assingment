
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zenzo/core/theme/theme.dart';
import 'package:zenzo/widgets/common/bottom_nav.dart';

import 'controllers/CartController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(CartController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zenzo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.zenzoTheme,
      home: const BottomNav(),
    );
  }
}
