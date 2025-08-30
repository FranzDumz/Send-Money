import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/core/constants/app_strings.dart';

import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/elevated_button.dart';

import '../../auth/presentation/cubit/session/session_cubit.dart';
import '../../auth/presentation/cubit/session/session_state.dart';

class SendMoneyDashBoard extends StatelessWidget {
  const SendMoneyDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SendMoneyDashBoardView();
  }
}

class _SendMoneyDashBoardView extends StatefulWidget {
  const _SendMoneyDashBoardView({super.key});

  @override
  State<_SendMoneyDashBoardView> createState() =>
      _SendMoneyDashBoardViewState();
}

class _SendMoneyDashBoardViewState extends State<_SendMoneyDashBoardView> {
  final ValueNotifier<bool> showBalance = ValueNotifier(true);

  @override
  void dispose() {
    showBalance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        if (state is SessionInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is SessionInvalid) {
          return Scaffold(
            body: Center(
              child: Text(
                'No user session available',
                style: theme.textTheme.bodyLarge,
              ),
            ),
          );
        }

        if (state is SessionValid) {
          final user = state.user;

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: const ReusableAppBar(
              title: AppStrings.sendMoneyApp,
              showLogout: true,
            ),
            body: RefreshIndicator(

              onRefresh: () async {
                await context.read<SessionCubit>().checkSession();
              },
              color: colorScheme.primary,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Balance card
                  ValueListenableBuilder<bool>(
                    valueListenable: showBalance,
                    builder: (context, value, _) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        color: theme.cardColor,
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Balance',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    value
                                        ? '₱${user.balance.toStringAsFixed(2)}'
                                        : '*' *
                                            '₱${user.balance.toStringAsFixed(2)}'
                                                .length,
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: theme.iconTheme.color,
                                ),
                                onPressed: () {
                                  showBalance.value = !showBalance.value;
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Buttons
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ReusableElevatedButton(
                          text: 'Send Money',
                          icon: Icons.send,
                          onPressed: () => context.push('/send'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        flex: 1,
                        child: ReusableElevatedButton(
                          text: 'Transaction',
                          icon: Icons.history,
                          onPressed: () => context.push('/transactions'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        // fallback
        return const SizedBox.shrink();
      },
    );
  }
}
