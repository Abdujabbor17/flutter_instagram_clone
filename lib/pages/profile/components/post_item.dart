

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/profile/profile_cubit.dart';
import '../../../model/post_model.dart';
import '../../../utils/custom_dialog.dart';

Widget itemOfHomePost(BuildContext context, Post post) {
  return GestureDetector(
      onLongPress: () async {

        var result = await dialogCommon(
            context, "Insta Clone", "Do you want to remove this post?", false);
        if (result) {
          BlocProvider.of<ProfileCubit>(context).removePost(post);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: post.imgPosts![0],
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            BlocProvider.of<ProfileCubit>(context).axisCount == 1 ?
            SizedBox(
              height: 35,
              child: Text(
                post.caption ?? '',
                style: TextStyle(color: Colors.black87.withOpacity(0.7)),
                maxLines: 2,
              ),
            ): const SizedBox.shrink()
          ],
        ),
      )
  );
}