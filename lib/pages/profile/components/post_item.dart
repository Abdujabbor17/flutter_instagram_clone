

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/post_model.dart';

Widget itemOfHomePost(Post post) {
  return GestureDetector(
      onLongPress: (){},
      child: Container(
        margin: const EdgeInsets.all(3),
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: post.postImage![0],
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ),
            // const SizedBox(
            //   height: 3,
            // ),
            // Text(
            //   post.caption ?? '',
            //   style: TextStyle(color: Colors.black87.withOpacity(0.7)),
            //   maxLines: 2,
            // )
          ],
        ),
      )
  );
}