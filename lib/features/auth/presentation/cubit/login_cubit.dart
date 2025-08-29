import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/flutter_secure_storage.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      emit(LoginError("Email and password cannot be empty"));
      return;
    }

    emit(LoginLoading());

    try {
      final user = await loginUseCase(LoginParams(username: username, password: password));
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
