import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/home/home_cubit.dart';
import 'package:flutter_instagram_clone/bloc/home/home_state.dart';
import '../../model/post_model.dart';
import 'components/itemOfPost.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Instagram",
            style: TextStyle(
                color: Colors.black, fontFamily: 'Billabong', fontSize: 30),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt),
              color: const Color.fromRGBO(193, 53, 132, 1),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (ctx, state) {
            if (state is HomeLoading) {
              return viewHome(posts, true);
            }

            if (state is HomeLoad) {
              posts = state.posts;
              return viewHome(posts, false);
            }

            if (state is HomeInit) {
              return viewHome(posts, false);
            }

            return const Center(
              child: Text('Oops!'),
            );
          },
        )
    );
  }

  Widget viewHome(List<Post> posts, bool isLoading) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: posts.length,
          itemBuilder: (ctx, index) {
            return itemOfPost(context, posts[index],
                  () {
                if(posts[index].liked){
                  BlocProvider.of<HomeCubit>(context).unLikePost(posts[index]);
                }else{
                  BlocProvider.of<HomeCubit>(context).likePost(posts[index]);
                }
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
