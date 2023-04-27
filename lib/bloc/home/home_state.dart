
import '../../model/post_model.dart';

abstract class HomeState{}

class HomeInit extends HomeState{}

class HomeLoad extends HomeState{
  List<Post> posts;

  HomeLoad({required this.posts});
}

class HomeError extends HomeState{
  String msg;
  HomeError(this.msg);
}

class HomeLoading extends HomeState{

}

