// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/transaction_history_cubit.dart';
// import '../../domain/entities/transaction_entity.dart';
//
// class TransactionHistoryPage extends StatelessWidget {
//   const TransactionHistoryPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Transaction History')),
//       body: BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
//         builder: (context, state) {
//           if (state is TransactionHistoryLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is TransactionHistoryLoaded) {
//             final transactions = state.transactions;
//             if (transactions.isEmpty) {
//               return const Center(child: Text('No transactions found.'));
//             }
//             return ListView.separated(
//               padding: const EdgeInsets.all(16),
//               itemCount: transactions.length,
//               separatorBuilder: (_, __) => const Divider(),
//               itemBuilder: (context, index) {
//                 final tx = transactions[index];
//                 return ListTile(
//                   title: Text(tx.receiver),
//                   subtitle: Text(tx.date.toLocal().toString()),
//                   trailing: Text(
//                     '- \$${tx.amount.toStringAsFixed(2)}',
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 );
//               },
//             );
//           } else if (state is TransactionHistoryError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
// }
