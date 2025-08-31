import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample/core/constants/send_money_strings.dart';
import 'package:sample/core/widgets/app_bar.dart';
import '../../../core/widgets/bottom_sheet.dart';
import '../../../core/widgets/elevated_button.dart';
import '../../../domain/usecases/send_money_usecase.dart';
import '../../auth/presentation/cubit/session/session_cubit.dart';
import '../cubit/send_money_cubit.dart';
import '../cubit/send_money_state.dart';
import '../../../data/repository/send_money_repository_impl.dart';
import '../../../data/datasources/send_money_datasource.dart';

class SendMoneyPage extends StatelessWidget {
  const SendMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    final currentUser = sessionCubit.getCurrentUser();

    return BlocProvider(
      create: (_) => SendMoneyCubit(
        SendMoneyUseCase(
          SendMoneyRepositoryImpl(
            SendMoneyRemoteDataSource(),
          ),
        ),
      ),
      child: _SendMoneyView(currentUser: currentUser),
    );
  }
}

class _SendMoneyView extends StatelessWidget {
  final dynamic currentUser;
  const _SendMoneyView({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sendMoneyCubit = context.read<SendMoneyCubit>();

    return Scaffold(
      appBar: const ReusableAppBar(
        title: SendMoneyStrings.sendMoneyTitle,
        showLogout: true,
        showBack: true,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: BlocConsumer<SendMoneyCubit, SendMoneyState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              showBottomMessage(
                context: context,
                title: SendMoneyStrings.failedTitle,
                message: state.errorMessage!,
                isSuccess: false,
              );
            }

            if (state.successMessage != null) {
              showBottomMessage(
                context: context,
                title: SendMoneyStrings.successTitle,
                message: state.successMessage!,
                isSuccess: true,
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                // Recipient Field
                TextFormField(
                  decoration: InputDecoration(
                    labelText: SendMoneyStrings.recipientLabel,
                    labelStyle: theme.textTheme.bodyMedium,
                    hintText: SendMoneyStrings.recipientHint,
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color:
                      theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: theme.textTheme.bodyMedium,
                  onChanged: sendMoneyCubit.updateRecipient,
                ),
                SizedBox(height: 16.h),

                // Amount Field
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: SendMoneyStrings.amountLabel,
                    labelStyle: theme.textTheme.bodyMedium,
                    hintText: SendMoneyStrings.amountHint,
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                      color:
                      theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: theme.textTheme.bodyMedium,
                  onChanged: sendMoneyCubit.updateAmount,
                ),
                SizedBox(height: 24.h),

                // Send Button
                SizedBox(
                  width: double.infinity,
                  child: ReusableElevatedButton(
                    text: state.isLoading
                        ? SendMoneyStrings.sending
                        : SendMoneyStrings.sendMoney,
                    icon: Icons.send,
                    onPressed: state.isLoading || currentUser == null
                        ? null
                        : () {
                      // Prevent sending money to self
                      if (state.recipient == currentUser.username.toString()) {
                        showBottomMessage(
                          context: context,
                          title: SendMoneyStrings.failedTitle,
                          message: SendMoneyStrings.selfTransferError,
                          isSuccess: false,
                        );
                        return;
                      }

                      sendMoneyCubit.sendMoney(currentUser.id);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
