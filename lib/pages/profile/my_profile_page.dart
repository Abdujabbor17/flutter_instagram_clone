import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/profile/profile_cubit.dart';
import 'package:flutter_instagram_clone/bloc/profile/profile_state.dart';
import '../../states.dart';
import '../upload/components/show_picker.dart';
import 'components/post_item.dart';


class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  bool isLoading = false;
  String fullName = "", email = "", imgUrl = "";
  int count_posts = 0, count_followers = 0, count_following = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Profile",
            style: TextStyle(
                color: Colors.black, fontFamily: "Billabong", fontSize: 25),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.exit_to_app),
              color: const Color.fromRGBO(193, 53, 132, 1),
            )
          ],
        ),
    body: BlocProvider<ProfileCubit>(
      create: (_) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit,ProfileState>(
        builder: (BuildContext ctx, state){
          if(state is ProfileInit){
            return viewProfile(ctx);
          }

          return const Center(child: Text('Oops!'),);
        },
      ),
    )
    );
  }

  viewProfile(BuildContext context){
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              //#myphoto
              GestureDetector(
                  onTap: () {
                    showPicker(context);
                  },
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(
                            width: 1.5,
                            color: const Color.fromRGBO(193, 53, 132, 1),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: imgUrl.isEmpty
                              ? const Image(
                            image: AssetImage(
                                "assets/images/ic_person.png"),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                              : CachedNetworkImage(
                            imageUrl: imgUrl,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.add_circle,
                              color: Colors.purple,
                            )
                          ],
                        ),
                      ),
                    ],
                  )),

              //#myinfos
              const SizedBox(
                height: 10,
              ),
              Text(
                fullName.toUpperCase(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                email,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),

              //#mycounts
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              count_posts.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "POSTS",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              count_followers.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "FOLLOWERS",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              count_following.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            const Text(
                              "FOLLOWING",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //list or grid
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<ProfileCubit>(context).changeAxisCount(1);
                        },
                        icon: const Icon(Icons.list_alt),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<ProfileCubit>(context).changeAxisCount(3);
                        },
                        icon: const Icon(Icons.grid_view),
                      ),
                    ),
                  ),
                ],
              ),

              //#myposts
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.watch<ProfileCubit>().axisCount),
                  itemCount: items.length,
                  itemBuilder: (ctx, index) {
                    return itemOfHomePost(items[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
