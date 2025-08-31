import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/core/constants/login_strings.dart';
import 'package:sample/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:sample/features/auth/presentation/cubit/session/session_cubit.dart';

import '../../../../core/storage/flutter_secure_storage.dart';
import '../../../../core/widgets/loading_dialog.dart';
import '../../../../data/datasources/login_datasources.dart';
import '../../../../data/repository/auth_repository_impl.dart';
import '../../../../domain/usecases/login_usecase.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionCubit(SecureStorageService()),
      child: BlocProvider(
        create: (context) => LoginCubit(
          LoginUseCase(
            LoginRepository(
              LoginRemoteDataSource(),
            ),
          ),
          context.read<SessionCubit>(), // inject session cubit here
        ),
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
            usernameController.text.trim(),
            passwordController.text.trim(),
          );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    LoadingDialog.show(context);
                  } else if (state is LoginSuccess) {
                    if (Navigator.canPop(context)) {
                      LoadingDialog.hide(context);
                      context.read<SessionCubit>().saveSession(state.user);
                      context.go('/dashboard', extra: state.user);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(LoginStrings.loginSuccess)),
                    );
                  } else if (state is LoginError) {
                    if (Navigator.canPop(context)) {
                      LoadingDialog.hide(context);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error.toString())),
                    );
                  }
                },
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const Text(
                          LoginStrings.loginTitle,
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          key: const Key("usernameField"),
                          controller: usernameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: LoginStrings.usernameHint,
                            prefixIcon: const Icon(Icons.person_2_sharp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          key: const Key("passwordField"),
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: LoginStrings.passwordHint,
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Password is required";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            key: const Key('loginButton'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: Colors.green,
                            ),
                            onPressed: _onLogin,
                            child: const Text(
                              LoginStrings.loginButton,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
