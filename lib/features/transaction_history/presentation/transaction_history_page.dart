import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/transaction_strings.dart';
import '../../../core/utils/date_formatters.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/bottom_sheet.dart';
import '../../../data/datasources/transaction_datasource.dart';
import '../../../data/repository/transaction_repository_impl.dart';
import '../../../domain/usecases/transaction_usecase.dart';
import '../../auth/presentation/cubit/session/session_cubit.dart';
import '../cubit/transaction_cubit.dart';
import '../cubit/transaction_state.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    final currentUser = sessionCubit.getCurrentUser();

    if (currentUser == null) {
      return const Center(child: Text(TransactionStrings.noUserSession));
    }

    final remoteDataSource = TransactionRemoteDataSourceImpl();
    final repository = TransactionRepositoryImpl(remoteDataSource: remoteDataSource);
    final useCase = GetTransactionsUseCase(repository: repository);

    return BlocProvider(
      create: (_) => TransactionCubit(useCase)..loadTransactions(currentUser.id),
      child: const _TransactionHistoryView(),
    );
  }
}

class _TransactionHistoryView extends StatelessWidget {
  const _TransactionHistoryView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionCubit>();

    return Scaffold(
      appBar: const ReusableAppBar(
        title: TransactionStrings.transactionHistoryTitle,
        showLogout: true,
        showBack: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocConsumer<TransactionCubit, TransactionState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              showBottomMessage(
                context: context,
                title: TransactionStrings.failedTitle,
                message: state.errorMessage!,
                isSuccess: false,
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.transactions.isEmpty) {
              return Center(
                child: Text(
                  TransactionStrings.noTransactions,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              );
            }

            return RefreshIndicator(
              color: Theme.of(context).colorScheme.primary,
              onRefresh: () async {
                final sessionCubit = context.read<SessionCubit>();
                final currentUser = sessionCubit.getCurrentUser();
                if (currentUser != null) {
                  await cubit.loadTransactions(currentUser.id);
                }
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  final tx = state.transactions[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                        tx.type == 'debit' ? Colors.red : Colors.green,
                        child: Icon(
                          tx.type == 'debit'
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(tx.counterparty),
                      subtitle: Text(DateFormatter.toYearMonthDay(tx.date)),
                      trailing: Text(
                        '₱${tx.amount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: tx.type == 'debit' ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
