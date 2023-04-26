

import 'package:flutter_instagram_clone/model/user_model.dart';

abstract class SearchState{}

class SearchInit extends SearchState{}

class SearchLoad extends SearchState{
  List<UserModel> users;

  SearchLoad({required this.users});
}

class SearchError extends SearchState{
  String msg;
  SearchError(this.msg);
}

class SearchLoading extends SearchState{}
