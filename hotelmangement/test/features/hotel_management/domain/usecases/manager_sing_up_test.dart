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
  late ManagerRepository mockManagerRepository;

  setUp(() {
    mockManagerRepository = MockManagerRepository();
    usecase = ManagerSignUp(repository: mockManagerRepository);
  });

  test(
      "should update manager details and return the updated manager when the repository call is successful",
      () async {
    // arrange
    final String id = "1";
    final String username = "testUser";
    final String phoneNumber = "testPhoneNumber";

    final Manager manager = Manager(
        id: id,
        username: username,
        phoneNumber: phoneNumber,
        email: "testEmail@test.com");

    when(mockManagerRepository.addManager(id))
        .thenAnswer((_) async => Right(manager));

    // act
    final result = await usecase(Params(id: id));

    //assert
    expect(Right(manager), result);
    verify(mockManagerRepository.addManager(id)).called(1);
    verifyNoMoreInteractions(mockManagerRepository);
  });
}
