import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/upload/upload_cubit.dart';
import 'package:flutter_instagram_clone/pages/auth/signin_page.dart';
import 'package:flutter_instagram_clone/pages/auth/signup_page.dart';
import 'package:flutter_instagram_clone/pages/main_view.dart';
import 'package:flutter_instagram_clone/pages/splash_page.dart';
import 'bloc/profile/profile_cubit.dart';
import 'bloc/search/search_cubit.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(  create: (context) => UploadCubit()),
          BlocProvider(  create: (context) => ProfileCubit()),
          BlocProvider(  create: (context) => SearchCubit()),
        ],
           child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
      routes: {
       // '/SplashPage': (context) => const SplashPage(),
        '/SignInPage': (context) => const SignInPage(),
        '/SignUpPage': (context) => const SignUpPage(),
        '/MainView': (context) => const MainView(),
      },
    );
  }
}

