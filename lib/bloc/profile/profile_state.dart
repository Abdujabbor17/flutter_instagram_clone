

import 'package:flutter_instagram_clone/model/post_model.dart';
import 'package:flutter_instagram_clone/model/user_model.dart';

abstract class ProfileState{}

class ProfileInit extends ProfileState{}

class ProfileLoad extends ProfileState{
  UserModel user;
  List<Post> posts;

  ProfileLoad({required this.user, required this.posts, });
}

class ProfileError extends ProfileState{
  String msg;
  ProfileError(this.msg);
}

class ProfileLoading extends ProfileState{

}

