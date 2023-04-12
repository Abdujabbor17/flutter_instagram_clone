import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/pages/auth/signin_page.dart';
import 'package:flutter_instagram_clone/pages/auth/signup_page.dart';
import 'package:flutter_instagram_clone/pages/auth/splash_page.dart';
import 'package:flutter_instagram_clone/pages/home/home_page.dart';
import 'package:flutter_instagram_clone/pages/main_view.dart';

import 'bloc/main_view/bottom_cubit.dart';

void main() {
  runApp(
      const MyApp());
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

