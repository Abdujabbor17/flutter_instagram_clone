import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/service/db_service.dart';
import 'package:flutter_instagram_clone/utils/log_service.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInit());


  void getPosts() async {
    emit(HomeLoading());
    var posts = await DBService.loadFeeds();
    posts.sort((a, b) => b.date!.compareTo(a.date!));
    emit(HomeLoad(posts: posts));
  }
}
