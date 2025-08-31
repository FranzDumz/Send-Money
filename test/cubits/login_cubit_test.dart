import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sample/domain/entities/user_entity.dart';
import 'package:sample/domain/usecases/login_usecase.dart';
import 'package:sample/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:sample/features/auth/presentation/cubit/session/session_cubit.dart';

// Mocks
class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockSessionCubit extends Mock implements SessionCubit {}

// Fake class for mocktail
class FakeLoginParams extends Fake implements LoginParams {}

void main() {
  late LoginCubit loginCubit;
  late MockLoginUseCase mockLoginUseCase;
  late MockSessionCubit mockSessionCubit;

  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockSessionCubit = MockSessionCubit();
    loginCubit = LoginCubit(mockLoginUseCase, mockSessionCubit);
  });

  final testUser = UserEntity(
    id: '1',
    name: 'Test User',
    balance: 1000,
    transactions: [],
    username: '',
  );

  group('LoginCubit', () {
    test('initial state is LoginInitial', () {
      expect(loginCubit.state, LoginInitial());
    });

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login succeeds',
      setUp: () {
        when(() => mockLoginUseCase.call(any())).thenAnswer((_) async => testUser);
        when(() => mockSessionCubit.saveSession(testUser)).thenAnswer((_) async {});
      },
      build: () => loginCubit,
      act: (cubit) => cubit.login('username', 'password'),
      expect: () => [LoginLoading(), LoginSuccess(testUser)],
      verify: (_) {
        verify(() => mockLoginUseCase.call(any())).called(1);
        verify(() => mockSessionCubit.saveSession(testUser)).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginError] when login fails',
      setUp: () {
        when(() => mockLoginUseCase.call(any())).thenThrow(Exception('Login failed'));
      },
      build: () => loginCubit,
      act: (cubit) => cubit.login('username', 'password'),
      expect: () => [LoginLoading(), isA<LoginError>()],
      verify: (_) {
        verify(() => mockLoginUseCase.call(any())).called(1);
      },
    );
  });
}
