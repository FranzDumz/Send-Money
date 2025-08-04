// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/wallet_cubit.dart';
//
// class WalletPage extends StatelessWidget {
//   const WalletPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<WalletCubit, WalletState>(
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(title: const Text('Wallet')),
//           body: state is WalletLoaded
//               ? Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Balance: ₱${state.balance.toStringAsFixed(2)}',
//                 style: const TextStyle(fontSize: 24),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/send');
//                 },
//                 child: const Text('Send Money'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/transactions');
//                 },
//                 child: const Text('Transaction History'),
//               ),
//             ],
//           )
//               : const Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
// }
