
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/upload/upload_cubit.dart';
import 'package:flutter_instagram_clone/pages/auth/signin_page.dart';
import 'package:flutter_instagram_clone/pages/auth/signup_page.dart';
import 'package:flutter_instagram_clone/pages/main_view.dart';


void main() {
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(  create: (context) => UploadCubit())
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
      home: const MainView(),
      routes: {
       // '/SplashPage': (context) => const SplashPage(),
        '/SignInPage': (context) => const SignInPage(),
        '/SignUpPage': (context) => const SignUpPage(),
        '/MainView': (context) => const MainView(),
      },
    );
  }
}

