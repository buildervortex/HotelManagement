import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotelmangement/features/hotel_management/domain/usecases/manager_sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SupabaseClient client;
  String clientId = "5eaf5c7d-1f4d-443f-a5e0-2ad2e5a69ed7";
  bool isManager = false;
  final ManagerSignUp managerSignUpUsecase;

  AuthCubit({required this.client, required this.managerSignUpUsecase})
      : super(AuthInitial());

  Future<void> singUpUser(String email, String password, String username,
      String phoneNumber) async {
    final response = await client.auth.signUp(password: password, email: email);

    if (response.user != null) {
      clientId = response.user!.id;
    } else {
      return emit(LogOut());
    }

    final result = await _userProfileRegister(username, phoneNumber, clientId);
    if (!result) {
      return emit(LogOut());
    }
    isManager = false;
    emit(LoggingUser(userId: clientId, isManager: isManager));
  }

  Future<void> singUpManager(String email, String password, String username,
      String phoneNumber) async {
    final response = await client.auth.signUp(password: password, email: email);
    print(response);

    if (response.user != null) {
      clientId = response.user!.id;
    } else {
      return emit(LogOut());
    }

    final result = await _userProfileRegister(username, phoneNumber, clientId);
    if (!result) {
      return emit(LogOut());
    }

    final managerResult = await managerSignUpUsecase(Params(id: clientId));
    print(managerResult);

    managerResult.fold((error) => emit(LogOut()), (manager) {
      isManager = true;
      return emit(LoggingUser(userId: clientId, isManager: isManager));
    });
  }

  Future<void> loginManagerOrUser(String email, String password) async {
    final response =
        await client.auth.signInWithPassword(password: password, email: email);

    if (response.user != null) {
      clientId = response.user!.id;
    } else {
      return emit(LogOut());
    }

    final manager =
        await client.from("manager").select().eq("id", clientId).maybeSingle();

    if (manager == null) {
      isManager = false;
      return emit(LoggingUser(userId: clientId, isManager: false));
    }
    isManager = true;
    emit(LoggingUser(userId: clientId, isManager: true));
  }

  Future<bool> _userProfileRegister(
      String username, String phonenumber, String userId) async {
    try {
      await client
          .from("profile")
          .insert({"username": username, "phonenumber": phonenumber});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logOut() async {
    await client.auth.signOut();
    clientId = "";
    isManager = false;
    emit(LogOut());
  }
}
