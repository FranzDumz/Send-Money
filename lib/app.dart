import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/core/constants/app_strings.dart';
import 'package:sample/core/theme/dark_theme.dart';
import 'package:sample/core/route/app_routes.dart';
import 'package:sample/features/dashboard/cubit/dashboard_cubit.dart';

import 'core/storage/flutter_secure_storage.dart';
import 'data/datasources/send_money_datasource.dart';
import 'data/repository/send_money_repository_impl.dart';
import 'domain/usecases/send_money_usecase.dart';
import 'features/auth/presentation/cubit/session/session_cubit.dart';
import 'features/send_money/cubit/send_money_cubit.dart';

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
            BlocProvider<SessionCubit>(
              create: (_) => SessionCubit(SecureStorageService())..checkSession(),
            ),
            BlocProvider<DashboardCubit>(
              create: (context) => DashboardCubit(
                sessionCubit: context.read<SessionCubit>(),
              )..loadUserFromSession(),
            ),
            BlocProvider<SendMoneyCubit>(
              create: (_) => SendMoneyCubit(
                SendMoneyUseCase(
                  SendMoneyRepositoryImpl(
                    SendMoneyRemoteDataSource(), // 👈 your data source
                  ),
                ),
              ),
            ),
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
