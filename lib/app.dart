import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/core/constants/app_strings.dart';
import 'package:sample/core/theme/dark_theme.dart';
import 'package:sample/core/route/app_routes.dart';
import 'core/storage/flutter_secure_storage.dart';
import 'features/auth/presentation/cubit/session/session_cubit.dart';

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
              create: (_) =>
                  SessionCubit(SecureStorageService())..checkSession(),
            ),
          ],
          child: MaterialApp.router(
            title: AppStrings.sendMoneyApp,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: ThemeMode.dark,
            // or ThemeMode.light / ThemeMode.system
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
