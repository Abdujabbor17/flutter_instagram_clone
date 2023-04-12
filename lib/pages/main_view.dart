import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/main_view/bottom_cubit.dart';
import '../utils/log_service.dart';
import 'home/home_page.dart';
import 'favorite/my_likes_page.dart';
import 'profile/my_profile_page.dart';
import 'search/my_search_page.dart';
import 'upload/my_upload_page.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  var list = [
    const HomePage(),
    const MySearchPage(),
    const MyUploadPage(),
    const MyLikesPage(),
    const MyProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BottomNavigationCubit(),
        child: BlocBuilder<BottomNavigationCubit, int>(
          builder: (context, state){
            return Scaffold(
              body: list[state],
              bottomNavigationBar:  BottomNavigationBar(
                  currentIndex: state,
                  onTap: (index){
                    BlocProvider.of<BottomNavigationCubit>(context).updateTab(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: const Color.fromRGBO(193, 53, 132, 1),
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: const [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(
                        Icons.home,
                        size: 32,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Search',
                      icon: Icon(
                        Icons.search,
                        size: 32,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Upload',
                      icon: Icon(
                        Icons.add_box,
                        size: 32,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Favorite',
                      icon: Icon(
                        Icons.favorite,
                        size: 32,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Profile',
                      icon: Icon(
                        Icons.account_circle,
                        size: 32,
                      ),
                    )
                  ])
            );

          },
        ),
      );


  }
}