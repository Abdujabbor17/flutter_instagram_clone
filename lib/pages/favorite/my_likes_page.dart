
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/pages/home/components/itemOfPost.dart';

import '../../bloc/favorite/like_cubit.dart';
import '../../bloc/favorite/like_state.dart';
import '../../model/post_model.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({Key? key}) : super(key: key);

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {

  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LikeCubit>(context).getLikedPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Likes",
          style: TextStyle(
              color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
        ),
      ),
      body: BlocBuilder<LikeCubit, LikeState>(
        builder: (ctx, state) {
          if (state is LikeLoading) {
            return viewLike(posts, true);
          }

          if (state is LikeLoad) {
            posts = state.posts;
            return viewLike(posts, false);
          }

          if (state is LikeInit) {
            return viewLike(posts, false);
          }

          return const Center(
            child: Text('Oops!'),
          );
        },
      ),

    );
  }

  Widget viewLike(List<Post> posts, bool isLoading) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: posts.length,
          itemBuilder: (ctx, index) {
            return itemOfPost(context, posts[index],
                  () {
                  BlocProvider.of<LikeCubit>(context)
                      .unLikePost(posts[index]);
              },
            );
          },
        ),
        isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : const SizedBox.shrink(),
      ],
    );
  }
}
