
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/auth/sign_up_state.dart';
import 'package:flutter_instagram_clone/model/user_model.dart';
import 'package:flutter_instagram_clone/service/auth_service.dart';

import '../../service/db_service.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInit());

  void signUp(String fullName, String email, String password) async {
    emit(AuthLoading());
    final response = await AuthService.signUpUser(fullName, email, password);

    if(response != null){
      UserModel user = UserModel(fullName, email);
      DBService.saveUser(user);
      emit(AuthSuccess());
    }else{
      emit(AuthError('Something is wrong'));
    }
  }

  Future<void> signIn( String email, String password) async {
    emit(AuthLoading());
    final response = await AuthService.signInUser( email, password);

    if(response != null){
      emit(AuthSuccess());
    }else{
      emit(AuthError('Something is wrong'));
    }
  }

}
