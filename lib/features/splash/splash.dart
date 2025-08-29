import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage/flutter_secure_storage.dart';
import '../auth/presentation/cubit/session/session_cubit.dart';
import '../auth/presentation/cubit/session/session_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Create the cubit and check session
    final cubit = SessionCubit(SecureStorageService());
    cubit.checkSession();

    // Delay for 2-3 seconds for splash display
    Timer(const Duration(seconds: 3), () {
      final state = cubit.state;
      if (state is SessionValid) {
        context.go('/dashboard');
      } else {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionCubit(SecureStorageService())..checkSession(),
      child: const Scaffold(

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Simple logo
              Icon(
                Icons.account_balance_wallet,
                size: 100,
                color: Colors.green,
              ),
               SizedBox(height: 24),
              // App name or tagline
               Text(
                "SendMoney App",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
               SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
