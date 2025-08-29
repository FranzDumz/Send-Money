import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/core/constants/app_strings.dart';
import 'package:sample/core/theme/dark_theme.dart';
import 'package:sample/core/route/app_routes.dart';
import 'package:sample/features/dashboard/cubit/dashboard_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<DashboardCubit>(
              create: (_) => DashboardCubit()..loadUserFromStorage(),
            ),
            // Add other cubits here if needed
          ],
          child: MaterialApp.router(
            title: AppStrings.sendMoneyApp,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: ThemeMode.dark, // or ThemeMode.light / ThemeMode.system
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
