import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sample/domain/entities/user_entity.dart';
import 'package:sample/domain/usecases/dashboard_usecase.dart';
import 'package:sample/features/auth/presentation/cubit/session/session_cubit.dart';
import 'package:sample/features/auth/presentation/cubit/session/session_state.dart';
import 'package:sample/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:sample/features/dashboard/cubit/dashboard_state.dart';

// --- Mocks ---
class MockSessionCubit extends Mock implements SessionCubit {}
class MockDashBoardUseCase extends Mock implements DashBoardUseCase {}
class FakeUserEntity extends Fake implements UserEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeUserEntity());
  });

  late MockSessionCubit mockSessionCubit;
  late MockDashBoardUseCase mockDashBoardUseCase;
  late DashboardCubit dashboardCubit;

  final testUser = UserEntity(
    id: '1',
    name: 'Test User',
    balance: 1000,
    transactions: [],
    username: 'testuser',
  );

  setUp(() {
    mockSessionCubit = MockSessionCubit();
    mockDashBoardUseCase = MockDashBoardUseCase();

    // Provide a valid user in session
    when(() => mockSessionCubit.state).thenReturn(SessionValid(user: testUser));
    whenListen(mockSessionCubit, const Stream<SessionState>.empty());

    dashboardCubit = DashboardCubit(
      sessionCubit: mockSessionCubit,
      getUserUseCase: mockDashBoardUseCase,
    );
  });

  group('DashboardCubit', () {
    test('initial state is DashBoardInitial', () {
      expect(dashboardCubit.state, isA<DashBoardInitial>());
    });

    blocTest<DashboardCubit, DashBoardState>(
      'emits [UserRefreshLoading, UserRefreshSuccess] when refresh succeeds',
      setUp: () {
        when(() => mockDashBoardUseCase.call(any()))
            .thenAnswer((_) async => testUser);
        when(() => mockSessionCubit.saveSession(any()))
            .thenAnswer((_) async {});
      },
      build: () => dashboardCubit,
      act: (cubit) => cubit.refreshUserData(),
      expect: () => [
        isA<UserRefreshLoading>(),
        isA<UserRefreshSuccess>().having((s) => s.user, 'user', testUser),
      ],
      verify: (_) {
        verify(() => mockDashBoardUseCase.call(testUser.id)).called(1);
        verify(() => mockSessionCubit.saveSession(testUser)).called(1);
      },
    );

    blocTest<DashboardCubit, DashBoardState>(
      'emits [UserRefreshLoading, UserRefreshError] when refresh fails',
      setUp: () {
        when(() => mockDashBoardUseCase.call(any()))
            .thenThrow(Exception('Failed to fetch user'));
      },
      build: () => dashboardCubit,
      act: (cubit) => cubit.refreshUserData(),
      expect: () => [
        isA<UserRefreshLoading>(),
        isA<UserRefreshError>().having(
              (e) => e.errorMessage,
          'errorMessage',
          contains('Failed to fetch user'),
        ),
      ],
      verify: (_) {
        verify(() => mockDashBoardUseCase.call(testUser.id)).called(1);
      },
    );
  });
}
