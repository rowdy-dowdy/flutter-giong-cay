import 'package:sample/models/user_model.dart';

enum AuthState {
  initial,
  login,
  notLogin
}

enum AuthType {
  teacher,
  student
}

class AuthModel {
  final AuthState authState;
  final UserModel? user;
  
  AuthModel({
    required this.user,
    required this.authState,
  });

  const AuthModel.unknown()
    : authState = AuthState.initial,
      user = null;

  AuthModel changeState (AuthState authState) {
    return AuthModel(user: user, authState: authState);
  }
}