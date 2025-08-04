import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sample/domain/entities/user_entity.dart';
import 'package:sample/features/auth/presentation/cubit/login_cubit.dart';


import '../../widgets/login_page_test.mocks.dart';


void main() {
  late MockLoginUseCase mockLoginUseCase;
  late LoginCubit loginCubit;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginCubit = LoginCubit(mockLoginUseCase);
  });

  test('emits [Loading, Success] when login succeeds', () async {
    final user = UserEntity(email: 'test@example.com', name: 'Francis', id: '1');
    when(mockLoginUseCase.call('test@example.com', 'password'))
        .thenAnswer((_) async => user);

    expectLater(
      loginCubit.stream,
      emitsInOrder([
        isA<LoginLoading>(),
        isA<LoginSuccess>().having((s) => s.user.email, 'email', 'test@example.com'),
      ]),
    );

    await loginCubit.login('test@example.com', 'password');
  });

  test('emits [Loading, Error] when login fails', () async {
    when(mockLoginUseCase.call('fail@example.com', 'wrong'))
        .thenThrow(Exception('Login failed'));

    expectLater(
      loginCubit.stream,
      emitsInOrder([
        isA<LoginLoading>(),
        isA<LoginError>().having((s) => s.message, 'message', contains('Login failed')),
      ]),
    );

    await loginCubit.login('fail@example.com', 'wrong');
  });
}
