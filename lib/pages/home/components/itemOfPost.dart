import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/home/home_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../bloc/home/page_view_cubit.dart';
import '../../../model/post_model.dart';
import '../../../utils/custom_dialog.dart';
import '../../../utils/log_service.dart';


Widget itemOfPost(BuildContext context, Post post, void Function() onTapLike) {
  return BlocProvider<ImageCubit>(
    create: (_) => ImageCubit(),
  child: BlocBuilder<ImageCubit, int>(
    builder: (context,state){
      return  Container(
        color: Colors.white,
        child: Column(
          children: [
            const Divider(),
            //#user info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: post.imgUser == null
                            ? const Image(
                          image: AssetImage("assets/images/ic_person.png"),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          post.imgUser! ,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.fullName ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                           Text(
                            post.date ?? 'recently',
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                  post.mine
                      ? IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () async {
                      var result = await dialogCommon(
                          context, "Insta Clone", "Do you want to remove this post?", false);
                      if (result) {
                        BlocProvider.of<HomeCubit>(context).removePost(post);
                      }
                    },
                  )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            //#post image
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onDoubleTap: onTapLike,
              child: SizedBox(
                height: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  onPageChanged: (index){
                    context.read<ImageCubit>().changeImage(index);
                  },
                  controller: context.watch<ImageCubit>().pageController,
                  itemCount: post.imgPosts != null ?  post.imgPosts!.length : 0,
                  itemBuilder: (context,index){
                    return  CachedNetworkImage(
                      width: MediaQuery.of(context).size.width,
                      imageUrl: post.imgPosts![index],
                      placeholder: (context, url) =>  Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Padding(
                            padding:  const EdgeInsets.all(13),
                            child: Container(
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade600,
                              ),
                            ),
                          )),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            //#like share
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width /2- 20,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: onTapLike,
                        icon: post.liked
                            ? const Icon(
                          EvaIcons.heart,
                          color: Colors.red,
                        )
                            : const Icon(
                          EvaIcons.heartOutline,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          EvaIcons.shareOutline,
                        ),
                      ),
                    ],
                  ),
                ),
                (post.imgPosts?.length ?? 0) > 1 ?
                SmoothPageIndicator(

                  controller: context.watch<ImageCubit>().pageController,
                  count: post.imgPosts!.length,
                  effect: const WormEffect(
                    dotWidth: 10.0,
                    dotHeight: 10.0,
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                  ),
                ): const SizedBox.shrink(),

              ],
            ),

            //#caption
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: RichText(
                softWrap: true,
                overflow: TextOverflow.visible,
                text: TextSpan(
                    text: post.caption,
                    style: const TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      );
    },
  ),
  );



}