import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/service/db_service.dart';

import '../../model/post_model.dart';
import 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit() : super(LikeInit());


  void getLikedPosts() async {
    emit(LikeLoading());
    var posts = await DBService.loadLikes();
    emit(LikeLoad(posts: posts));
  }

   void unLikePost(Post post) async{
    emit(LikeLoading());
    await DBService.likePost(post, false);
    getLikedPosts();
    emit(LikeInit());
  }


}
