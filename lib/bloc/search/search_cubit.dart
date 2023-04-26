
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/search/search_state.dart';
import 'package:flutter_instagram_clone/service/db_service.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInit());


  Future<void> searchUser(String keyword) async {
    emit(SearchLoading());
    var users = await DBService.searchUser(keyword);

    emit(SearchLoad(users: users));
  }

}