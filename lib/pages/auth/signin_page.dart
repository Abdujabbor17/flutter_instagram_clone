import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/sign_up_cubit.dart';
import '../../bloc/auth/sign_up_state.dart';
import '../../utils/log_service.dart';
import '../../utils/toast.dart';
import '../main_view.dart';


class SignInPage extends StatefulWidget {

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _callSignUpPage() {
    Navigator.pushReplacementNamed(context, '/SignUpPage');
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
              return view(ctx, false);
            }
            return view(ctx, false);
          },
        ),
      ),
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
                              hintStyle:
                              TextStyle(fontSize: 17, color: Colors.white54)),
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
                              hintStyle:
                              TextStyle(fontSize: 17, color: Colors.white54)),
                        ),
                      ),

                      //#signin
                      GestureDetector(
                        onTap: () async {
                          String email = emailController.text.toString().trim();
                          String password = passwordController.text.toString().trim();

                          if(email.isNotEmpty &&
                              password.isNotEmpty){
                          await  BlocProvider.of<AuthCubit>(context).signIn(email, password);
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
                                "Sign In",
                                style:
                                TextStyle(color: Colors.white, fontSize: 17),
                              ),
                            )),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don`t have an account?",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        _callSignUpPage();
                      },
                      child: const Text(
                        "Sign Up",
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
      ),
    );
  }
}
