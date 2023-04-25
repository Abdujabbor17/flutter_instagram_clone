

abstract class AuthState{}

class AuthInit extends AuthState{}

class AuthLoading extends AuthState{}

class AuthError extends AuthState{
  String msg;
  AuthError(this.msg);
}

class AuthSuccess extends AuthState{

}