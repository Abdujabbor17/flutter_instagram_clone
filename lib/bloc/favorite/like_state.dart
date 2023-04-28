
import '../../model/post_model.dart';

abstract class LikeState{}

class LikeInit extends LikeState{}

class LikeLoad extends LikeState{
  List<Post> posts;

  LikeLoad({required this.posts});
}

class LikeError extends LikeState{
  String msg;
  LikeError(this.msg);
}

class LikeLoading extends LikeState{

}

