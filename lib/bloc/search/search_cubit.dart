
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/search/search_state.dart';
import 'package:flutter_instagram_clone/service/db_service.dart';

import '../../model/user_model.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInit());


  Future<void> searchUser(String keyword) async {
    emit(SearchLoading());
    var users = await DBService.searchUser(keyword);

    emit(SearchLoad(users: users));
  }

  void followUser(UserModel user) async {
   emit(SearchLoading());
   await DBService.followUser(user);
   user.followed = true;

   await DBService.storePostsToMyFeed(user);
   emit(SearchInit());
  }

  void unFollowUser(UserModel user) async {
    emit(SearchLoading());
    await DBService.unfollowUser(user);
    user.followed = false;
    await DBService.removePostsFromMyFeed(user);
    emit(SearchInit());
  }
}