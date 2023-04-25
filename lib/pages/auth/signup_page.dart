import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_clone/bloc/auth/sign_up_cubit.dart';
import 'package:flutter_instagram_clone/bloc/auth/sign_up_state.dart';
import 'package:flutter_instagram_clone/pages/main_view.dart';

import '../../utils/toast.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cPasswordController = TextEditingController();

  _callSignInPage() {
    Navigator.pushReplacementNamed(context,'/SignInPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthCubit>(
        create: (_) => AuthCubit(),
        child: BlocBuilder<AuthCubit,AuthState>(
          builder: (ctx,state){
            if(state is AuthLoading){
              return view(ctx, true);
            }
             if(state is AuthInit){
              return view(ctx, false);
            }
              if(state is AuthError){
                toastError(state.msg);
              return view(ctx, false);
            }

            if (state is AuthSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainView()));
              });
              //Navigator.pushReplacementNamed(ctx, '/MainView');
            return view(ctx, false);
          }
            return view(ctx, false);
        },
        ),
      )
    );
  }

  Widget view(BuildContext context, bool isLoading){
    return Container(
        padding: const EdgeInsets.all(20),
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
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Instagram",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontFamily: "Billabong"),
                        ),

                        //#fullname
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 50,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)),
                          child: TextField(
                            controller: fullNameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "FullName",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 17, color: Colors.white54)),
                          ),
                        ),

                        //#email
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 50,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)),
                          child: TextField(
                            controller: emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "Email",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 17, color: Colors.white54)),
                          ),
                        ),

                        //#password
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 50,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "Password",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 17, color: Colors.white54)),
                          ),
                        ),

                        //#cpassword
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 50,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(7)),
                          child: TextField(
                            controller: cPasswordController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                hintText: "Confirm Password",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 17, color: Colors.white54)),
                          ),
                        ),

                        //#signin
                        GestureDetector(
                          onTap: () {
                            String fullName = fullNameController.text.toString().trim();
                            String email = emailController.text.toString().trim();
                            String password = passwordController.text.toString().trim();
                            String cPassword = cPasswordController.text.toString().trim();

                            if(
                            fullName.isNotEmpty &&
                            email.isNotEmpty &&
                            password.isNotEmpty &&
                            cPassword.isNotEmpty){
                              if(password == cPassword){
                                BlocProvider.of<AuthCubit>(context).signUp(fullName,email, password);
                              }else{
                                toastError('password and confirm password doesn\'t match');
                              }
                            }else{
                              toastError('Please fill completely');
                            }

                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              height: 50,
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(7)),
                              child: const Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              )),
                        ),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          _callSignInPage();
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
            isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : const SizedBox.shrink(),
          ],
        ));
  }
}
