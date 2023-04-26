

import 'package:flutter_instagram_clone/model/user_model.dart';

abstract class ProfileState{}

class ProfileInit extends ProfileState{}

class ProfileLoad extends ProfileState{
  UserModel user;

  ProfileLoad({required this.user});
}

class ProfileError extends ProfileState{
  String msg;
  ProfileError(this.msg);
}

class ProfileLoading extends ProfileState{

}

