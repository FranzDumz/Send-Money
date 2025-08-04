// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/transaction_cubit.dart';
//
// class TransactionPage extends StatelessWidget {
//   const TransactionPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TransactionCubit, TransactionState>(
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(title: const Text('Recent Transactions')),
//           body: state is TransactionLoaded
//               ? ListView.builder(
//             itemCount: state.transactions.length,
//             itemBuilder: (context, index) {
//               final tx = state.transactions[index];
//               return ListTile(
//                 title: Text(tx.receiverName),
//                 subtitle: Text(tx.date),
//                 trailing: Text('-₱${tx.amount.toStringAsFixed(2)}'),
//               );
//             },
//           )
//               : const Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
// }
