import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../features/dashboard/cubit/dashboard_cubit.dart';
import '../../features/auth/presentation/cubit/session/session_cubit.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showLogout;
  final bool showBack;

  const ReusableAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showLogout = false,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Build the actions list
    final List<Widget> finalActions = [];
    if (actions != null) finalActions.addAll(actions!);

    if (showLogout) {
      finalActions.add(
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          tooltip: 'Logout',
          onPressed: () async {
            final cubit = context.read<SessionCubit>();
            await cubit.clearSession();
            context.go('/login');
          },
        ),
      );
    }

    return AppBar(
      title: Text(
        title,
        style: theme.appBarTheme.titleTextStyle ?? theme.textTheme.titleMedium,
      ),
      backgroundColor: theme.appBarTheme.backgroundColor,
      elevation: theme.appBarTheme.elevation,
      leading: showBack
          ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        tooltip: 'Back',
        onPressed: () {
          if (context.canPop()) {
            context.pop(); // GoRouter pop
          } else {
            context.go('/'); // fallback (home/dashboard)
          }
        },
      )
          : null,
      actions: finalActions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
