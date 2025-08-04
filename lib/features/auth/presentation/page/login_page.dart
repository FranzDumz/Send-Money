import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample/core/constants/login_strings.dart';

import 'package:sample/features/auth/presentation/cubit/login_cubit.dart';

import '../../../../data/datasources/login_remote_datasources_impl.dart';
import '../../../../data/repository/auth_repository_impl.dart';
import '../../../../domain/usecases/login_usecase.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(
        LoginUseCase(
          LoginRepositoryImpl(
            LoginRemoteDataSourceImpl(),
          ),
        ),
      ),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _onLogin() {
    context.read<LoginCubit>().login(
          emailController.text,
          passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(LoginStrings.loginTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(LoginStrings.loginSuccess)),
              );
            } else if (state is LoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  key: const Key("emailField"),
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: LoginStrings.emailHint,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  key: const Key("passwordField"),
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: LoginStrings.passwordHint,
                  ),
                ),
                const SizedBox(height: 20),
                state is LoginLoading
                    ? const CircularProgressIndicator(key: Key("loginCircularProgressOnLogin"),)
                    : ElevatedButton(
                     key: const Key('loginButton'),
                        onPressed: _onLogin,
                        child: const Text(LoginStrings.loginButton),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
