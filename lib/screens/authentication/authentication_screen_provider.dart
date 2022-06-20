import 'package:authorization_app/screens/authentication/authentication_screen.dart';
import 'package:authorization_app/screens/authentication/cubit/cubit_authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationScreenProvider extends StatelessWidget {
  const AuthenticationScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CubitAuthenticationScreen>(
      create: (context) => CubitAuthenticationScreen(),
      child: const AuthenticationScreen(),
    );
  }
}
