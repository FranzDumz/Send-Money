import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';



import 'package:sample/domain/entities/user_entity.dart';
import 'package:sample/domain/usecases/login_usecase.dart';
import 'package:sample/features/auth/presentation/cubit/login_cubit.dart';
import 'package:sample/features/auth/presentation/page/login_page.dart';

import 'login_page_test.mocks.dart';

@GenerateMocks([LoginCubit, LoginUseCase])
void main() {
  late MockLoginCubit mockLoginCubit;

  setUp(() {
    mockLoginCubit = MockLoginCubit();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<LoginCubit>.value(
        value: mockLoginCubit,
        child: const LoginPage(),
      ),
    );
  }

  testWidgets('renders login form UI', (tester) async {
    when(mockLoginCubit.state).thenReturn(LoginInitial());

    await tester.pumpWidget(createTestWidget());

    expect(find.byKey(const Key("emailField")), findsOneWidget);
    expect(find.byKey(const Key("passwordField")), findsOneWidget);
    expect(find.byKey(const Key("loginButton")), findsOneWidget);
  });

  testWidgets('calls login on button press', (tester) async {
    final mockLoginUseCase = MockLoginUseCase();
    final loginCubit = LoginCubit(mockLoginUseCase);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (_) => loginCubit,
          child: const LoginPage(),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('emailField')), 'test@example.com');
    await tester.enterText(find.byKey(const Key('passwordField')), '123456');

    // Stub the use case
    when(mockLoginUseCase.call('test@example.com', '123456'))
        .thenAnswer((_) async => UserEntity(id: "1", name: "Francis", email: 'test@example.com'));

    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pumpAndSettle();

    verify(mockLoginUseCase.call('test@example.com', '123456')).called(1);
  });

  testWidgets('shows loading indicator when in loading state', (tester) async {
    when(mockLoginCubit.state).thenReturn(LoginLoading());

    await tester.pumpWidget(createTestWidget());

    expect(find.byKey(const Key("loginCircularProgressOnLogin")), findsOneWidget);
  });

  testWidgets('shows error message when in error state', (tester) async {
    when(mockLoginCubit.state).thenReturn(LoginError('Invalid credentials'));

    await tester.pumpWidget(createTestWidget());

    expect(find.text('Invalid credentials'), findsOneWidget);
  });

  testWidgets('shows success UI when login is successful', (tester) async {
    final fakeUser = UserEntity(id: "1", email: 'test@example.com', name: 'Francis');
    when(mockLoginCubit.state).thenReturn(LoginSuccess(fakeUser));

    await tester.pumpWidget(createTestWidget());

    expect(find.textContaining('Welcome'), findsOneWidget); // adjust if needed
  });
}
