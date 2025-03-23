import 'package:dartz/dartz.dart';
import 'package:hotelmangement/features/hotel_management/domain/entities/manager.dart';
import 'package:hotelmangement/features/hotel_management/domain/repositories/manager_repository.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/manager_sign_up.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'manager_sing_up_test.mocks.dart';

// flutter pub run build_runner build
@GenerateMocks([ManagerRepository])
void main() {
  late ManagerSignUp usecase;
  late MockManagerRepository mockManagerRepository;

  setUp(() {
    mockManagerRepository = MockManagerRepository();
    usecase = ManagerSignUp(repository: mockManagerRepository);
  });

  test(
      "should update manager details and return the updated manager when the repository call is successful",
      () async {
    // arrange
    final String role = "user";
    final String username = "testUser";
    final String phoneNumber = "testPhoneNumber";

    final Manager manager = Manager(
        id: "1",
        username: username,
        phoneNumber: phoneNumber,
        email: "testEmail@test.com",
        role: role);

    when(mockManagerRepository.updateManager(role, username, phoneNumber))
        .thenAnswer((_) async => Right(manager));

    // act
    final result = await usecase(
        Params(username: username, phoneNumber: phoneNumber, role: role));

    //assert
    expect(Right(manager), result);
    verify(mockManagerRepository.updateManager(role, username, phoneNumber))
        .called(1);
    verifyNoMoreInteractions(mockManagerRepository);
  });
}
