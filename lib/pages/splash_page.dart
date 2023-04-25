import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../utils/log_service.dart';



class SplashPage extends StatefulWidget {

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  _initTimer(){
    Timer(const Duration(seconds: 2), (){
      _callNextPage();
    });
  }

  _callNextPage(){
    Log.i(AuthService.isLoggedIn().toString());
    if(AuthService.isLoggedIn()){
      Navigator.pushReplacementNamed(context, '/MainView');
    }else{
      Navigator.pushReplacementNamed(context, '/SignInPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(193, 53, 132, 1),
                Color.fromRGBO(131, 58, 180, 1),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Expanded(
              child: Center(
                child: Text(
                  "Instagram",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontFamily: "Billabong"),
                ),
              ),
            ),
            Text(
              "From Meta",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
