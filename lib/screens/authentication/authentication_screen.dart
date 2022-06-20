import 'dart:developer';

import 'package:authorization_app/consts/consts.dart';
import 'package:authorization_app/screens/authentication/cubit/cubit_authentication_screen.dart';
import 'package:authorization_app/screens/authentication/cubit/state_authentication_screen.dart';
import 'package:authorization_app/screens/authentication/widgets/creditionals_input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen>
    with TickerProviderStateMixin {
  final Duration durationAuthContainer = const Duration(milliseconds: 1700);
  final Duration durationAuthForm = const Duration(milliseconds: 1500);
  final Duration durationOpacity = const Duration(milliseconds: 1000);
  final Duration reverseDuration = const Duration(milliseconds: 700);
  late final AnimationController _controllerAuthContainer;
  late final Animation<double> _animationAuthContainer;
  late final AnimationController _controllerAuthFormContainer;
  late final Animation<Offset> _animationAuthFormContainer;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String emailError = '';
  String passwordError = '';
  double scale = 1.0;
  double _opacityEmail = 0.0;
  double _opacityPassword = 0.0;
  double _opacityLoginButton = 0.0;
  double _opacityDanceElon = 0.0;
  double _opacityBadElon = 0.0;

  @override
  void initState() {
    _controllerAuthContainer = AnimationController(
      duration: durationAuthContainer,
      reverseDuration: reverseDuration,
      vsync: this,
    );
    _animationAuthContainer = CurvedAnimation(
      parent: _controllerAuthContainer,
      curve: Curves.fastOutSlowIn,
    );
    _controllerAuthFormContainer = AnimationController(
      duration: durationAuthForm,
      reverseDuration: reverseDuration,
      vsync: this,
    );
    _animationAuthFormContainer = Tween<Offset>(
            begin: const Offset(0.0, 1.5), end: const Offset(0.0, 0.4))
        .animate(_controllerAuthFormContainer)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          showOpacity('email');
          showOpacity('password');
          showOpacity('button');
        }
      });
    super.initState();
    _runAnimationsContainers();
  }

  @override
  void dispose() {
    _controllerAuthContainer.dispose();
    _controllerAuthFormContainer.dispose();
    super.dispose();
  }

  void _runAnimationsContainers() {
    _controllerAuthContainer.forward();
    _controllerAuthFormContainer.forward();
  }

  void _outAnimationsContainers() {
    _controllerAuthContainer.reverse();
    _controllerAuthFormContainer.reverse();
  }

  void _changeScale() async {
    setState(() => scale = 0.9);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => scale = 1.0);
  }

  void showOpacity(String name) {
    switch (name) {
      case 'email':
        setState(() {
          _opacityEmail = 1.0;
        });
        break;
      case 'password':
        setState(() {
          _opacityPassword = 1.0;
        });
        break;
      case 'button':
        setState(() {
          _opacityLoginButton = 1.0;
        });
        break;
      case 'badElon':
        setState(() {
          _opacityBadElon = 1.0;
        });
        break;
      case 'danceElon':
        setState(() {
          _opacityDanceElon = 1.0;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body:
            BlocConsumer<CubitAuthenticationScreen, StateAuthenticationScreen>(
                listener: (context, state) {
          if (state is StateAuthenticationScreenSuccess) {
            _outAnimationsContainers();
          }

          if (state is StateAuthenticationScreenShowDanceElon) {
            showOpacity('danceElon');
          } else if (state is StateAuthenticationScreenShowBadElon) {
            showOpacity('badElon');
          }
        }, builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(children: [
              Center(
                child: AnimatedOpacity(
                  duration: durationOpacity,
                  opacity: _opacityDanceElon,
                  child: Image.network(
                      'https://d1.skrinshoter.ru/s/250422/xnoyYOGB.png'),
                ),
              ),
              Center(
                child: AnimatedOpacity(
                  duration: durationOpacity,
                  opacity: _opacityBadElon,
                  child: Image.network(
                      'https://d1.skrinshoter.ru/s/250422/zJXaVrly.png'),
                ),
              ),
              SizeTransition(
                axisAlignment: 1.0,
                sizeFactor: _animationAuthContainer,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(185, 185, 185, 1),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  height: 1.1.sw,
                  child: const Center(
                    child: Text(
                      'Authorization',
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: SlideTransition(
                  position: _animationAuthFormContainer,
                  child: Container(
                      height: 900,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 82, 82, 82),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Center(
                        child: Column(
                          children: [
                            if (state is StateAuthenticationScreenError) ...[
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: SizedBox(
                                  child: Center(
                                    child: Text(state.message!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ] else if (state
                                is StateAuthenticationScreenLoading) ...[
                              const Padding(
                                padding: EdgeInsets.all(18.0),
                                child: SizedBox(
                                  child: Center(
                                      child: CupertinoActivityIndicator(
                                    color: Colors.white,
                                    animating: true,
                                    radius: 7,
                                  )),
                                ),
                              ),
                            ] else if (state
                                is StateAuthenticationScreenSuccess)
                              ...[]
                            else ...[
                              SizedBox(height: 40.h),
                            ],
                            AnimatedOpacity(
                              duration: durationOpacity,
                              opacity: _opacityEmail,
                              child: InputCreditionalsWidget(
                                controller: emailController,
                                hintText: 'E-mail',
                                keyboardType: TextInputType.emailAddress,
                                maxLength: maxLenghtEmailAddress,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            AnimatedOpacity(
                              duration: durationOpacity,
                              opacity: _opacityPassword,
                              child: InputCreditionalsWidget(
                                controller: passwordController,
                                hintText: 'Password',
                                maxLength: maxLenghtPassword,
                                obscureText: true,
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            AnimatedOpacity(
                              duration: durationOpacity,
                              opacity: _opacityLoginButton,
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 200),
                                scale: scale,
                                child: Container(
                                  width: 350.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 139, 139, 139),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        _changeScale();
                                        BlocProvider.of<
                                                    CubitAuthenticationScreen>(
                                                context)
                                            .login(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text);
                                      },
                                      child: const Text('Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ]),
          );
        }));
  }
}
