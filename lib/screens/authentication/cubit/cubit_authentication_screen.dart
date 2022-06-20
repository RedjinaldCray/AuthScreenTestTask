import 'dart:developer';

import 'package:authorization_app/screens/authentication/cubit/state_authentication_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class CubitAuthenticationScreen extends Cubit<StateAuthenticationScreen> {
  CubitAuthenticationScreen() : super(StateAuthenticationScreenInit());

  Future<void> login({required String email, required String password}) async {
    // check email
    bool emailIsEmpty = email.isEmpty;
    bool emailIsValid = EmailValidator.validate(email);
    bool emailIsMatchPassword = email == password;

    // check password
    bool passwordIsEmpty = password.isEmpty;
    bool passwordLenghtIsNotCorrect = password.length < 6;

    if (emailIsEmpty) {
      emit(StateAuthenticationScreenError(
          error: 401, message: "Email is empty"));
    } else if (!emailIsValid) {
      emit(StateAuthenticationScreenError(
          error: 401,
          message: "Entered email does not correspond to email form"));
    } else if (emailIsMatchPassword) {
      emit(StateAuthenticationScreenError(
          error: 401, message: "Email matches password"));
    } else if (passwordIsEmpty) {
      emit(StateAuthenticationScreenError(
          error: 401, message: "Password is empty"));
    } else if (passwordLenghtIsNotCorrect) {
      emit(StateAuthenticationScreenError(
          error: 401,
          message: "Password must consist of at least 6 characters or more"));
    } else {
      log('All nice: email: $email | password: $password');
      await GetStorage().write('token', 'JWTtokenHere');
      emit(StateAuthenticationScreenLoading());
      await Future.delayed(const Duration(seconds: 2), () {});
      emit(StateAuthenticationScreenSuccess());
      if (email.toLowerCase().contains('error')) {
        emit(StateAuthenticationScreenShowBadElon());
      } else {
        emit(StateAuthenticationScreenShowDanceElon());
      }
    }
  }
}
