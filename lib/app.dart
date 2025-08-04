import 'package:flutter/material.dart';
import 'package:sample/core/constants/app_strings.dart';
import 'package:sample/features/auth/presentation/page/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.sendMoneyApp,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}
