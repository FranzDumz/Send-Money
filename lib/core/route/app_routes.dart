
import 'package:go_router/go_router.dart';
import 'package:sample/features/auth/presentation/page/login_page.dart';

import '../../features/dashboard/presentation/dashboard.dart';
import '../../features/send_money/presentation/send_money.dart';
import '../../features/splash/splash.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const SendMoneyDashBoard(),
      ),
      GoRoute(
        path: '/send',
        name: 'sendMoney',
       builder: (context, state) => const SendMoneyPage(),
      ),
      // GoRoute(
      //   path: '/transactions',
      //   name: 'transactions',
      //  builder: (context, state) => const TransactionsPage(),
      // ),
    ],
  );
}
