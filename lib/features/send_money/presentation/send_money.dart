// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../cubit/send_money_cubit.dart';
//
// class SendMoneyPage extends StatefulWidget {
//   const SendMoneyPage({super.key});
//
//   @override
//   State<SendMoneyPage> createState() => _SendMoneyPageState();
// }
//
// class _SendMoneyPageState extends State<SendMoneyPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _receiverController = TextEditingController();
//   final _amountController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SendMoneyCubit, SendMoneyState>(
//       listener: (context, state) {
//         if (state is SendMoneySuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Money sent successfully!')),
//           );
//           Navigator.pop(context);
//         } else if (state is SendMoneyError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(title: const Text('Send Money')),
//           body: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _receiverController,
//                     decoration: const InputDecoration(labelText: 'Receiver Name'),
//                     validator: (value) => value == null || value.isEmpty
//                         ? 'Please enter receiver name'
//                         : null,
//                   ),
//                   TextFormField(
//                     controller: _amountController,
//                     decoration: const InputDecoration(labelText: 'Amount'),
//                     keyboardType: TextInputType.number,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter amount';
//                       }
//                       final amount = double.tryParse(value);
//                       if (amount == null || amount <= 0) {
//                         return 'Enter a valid amount';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: state is SendMoneyLoading
//                         ? null
//                         : () {
//                       if (_formKey.currentState!.validate()) {
//                         context.read<SendMoneyCubit>().sendMoney(
//                           receiver: _receiverController.text,
//                           amount: double.parse(_amountController.text),
//                         );
//                       }
//                     },
//                     child: state is SendMoneyLoading
//                         ? const CircularProgressIndicator()
//                         : const Text('Send'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _receiverController.dispose();
//     _amountController.dispose();
//     super.dispose();
//   }
// }
