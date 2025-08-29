// lib/core/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/features/auth/presentation/page/login_page.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
       // builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/send',
        name: 'sendMoney',
       // builder: (context, state) => const SendMoneyPage(),
      ),
      GoRoute(
        path: '/transactions',
        name: 'transactions',
       // builder: (context, state) => const TransactionsPage(),
      ),
    ],
  );
}
