import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/dashboard_strings.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/elevated_button.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../../auth/presentation/cubit/session/session_cubit.dart';
import '../../auth/presentation/cubit/session/session_state.dart';
import '../../../data/datasources/dashboard_datacource.dart';
import '../../../data/repository/dashboard_repositoy_impl.dart';
import '../../../domain/usecases/dashboard_usecase.dart';

class SendMoneyDashBoard extends StatelessWidget {
  const SendMoneyDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionCubit, SessionState>(
      listener: (context, sessionState) {
        if (sessionState is SessionInvalid) {
          context.go('/login');
        }
      },
      child: BlocProvider<DashboardCubit>(
        create: (_) => DashboardCubit(
          sessionCubit: context.read<SessionCubit>(),
          getUserUseCase: DashBoardUseCase(
            repository: DashboardRepositoryImpl(
              remoteDataSource: DashboardRemoteDataSourceImpl(),
            ),
          ),
        )..refreshUserData(),
        child: const _SendMoneyDashBoardView(),
      ),
    );
  }
}

class _SendMoneyDashBoardView extends StatefulWidget {
  const _SendMoneyDashBoardView();

  @override
  State<_SendMoneyDashBoardView> createState() =>
      _SendMoneyDashBoardViewState();
}

class _SendMoneyDashBoardViewState extends State<_SendMoneyDashBoardView> {
  final ValueNotifier<bool> showBalance = ValueNotifier(false);

  @override
  void dispose() {
    showBalance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<DashboardCubit, DashBoardState>(
      builder: (context, state) {
        final isLoading = state is UserRefreshLoading;
        final user = state is UserRefreshSuccess ? state.user : null;

        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: const ReusableAppBar(
            title: AppStrings.sendMoneyApp,
            showLogout: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async =>
                context.read<DashboardCubit>().refreshUserData(),
            color: colorScheme.primary,
            child: user == null
                ? Center(
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : state is UserRefreshError
                            ? Text(DashBoardStrings.failedToLoadUser,
                                style: theme.textTheme.bodyLarge)
                            : const SizedBox.shrink(),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: showBalance,
                        builder: (context, value, _) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                            color: theme.cardColor,
                            margin: const EdgeInsets.symmetric(vertical: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Hi ${user.name}",
                                          style: theme.textTheme.titleLarge),
                                      const SizedBox(height: 8),
                                      Text(DashBoardStrings.yourBalance,
                                          style: theme.textTheme.titleMedium),
                                      const SizedBox(height: 8),
                                      Text(
                                        value
                                            ? '₱${user.balance.toStringAsFixed(2)}'
                                            : '*' *
                                                '₱${user.balance.toStringAsFixed(2)}'
                                                    .length,
                                        style: theme.textTheme.headlineMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: Icon(
                                        value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: theme.iconTheme.color),
                                    onPressed: () =>
                                        showBalance.value = !showBalance.value,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Flexible(
                            child: ReusableElevatedButton(
                              text: DashBoardStrings.sendMoney,
                              icon: Icons.send,
                              onPressed: () => context.push('/send'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: ReusableElevatedButton(
                              text: DashBoardStrings.transactions,
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
      },
    );
  }
}
