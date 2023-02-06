import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pokemon_app_bloc/logic/cubits/auth_cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  // Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Form Keys
  final loginFormKey = GlobalKey<FormBuilderState>();
  final signUpFormKey = GlobalKey<FormBuilderState>();
  // Current User
  User? currentUser;
  // Cubit Initialization
  AuthCubit() : super(AuthInitialState()) {
    navigateToHomeOrSignIn();
  }

  void createUser() async {
    try {
      var email = signUpFormKey.currentState!.value["email"];
      var password = signUpFormKey.currentState!.value["password"];
      emit(AuthLoadingState());
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }

  void logIn() async {
    try {
      var email = loginFormKey.currentState!.value["email"];
      var password = loginFormKey.currentState!.value["password"];
      emit(AuthLoadingState());
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(userCredential.user!));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }

  Future navigateToHomeOrSignIn() async {
    emit(AuthInitialState());
    await Future.delayed(const Duration(seconds: 2));

    currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Logged In
      emit(AuthLoggedInState(currentUser!));
    } else {
      // Logged out
      emit(AuthLoggedOutState());
    }
  }

  // void verifyOTP(String otp) async {
  //   emit(AuthLoadingState());

  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: _verificationId!, smsCode: otp);
  //   signInWithPhone(credential);
  // }

  // void signInWithPhone(PhoneAuthCredential credential) async {
  //   try {
  //     UserCredential userCredential =
  //         await _auth.signInWithCredential(credential);
  //     if (userCredential.user != null) {
  //       emit(AuthLoggedInState(userCredential.user!));
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     emit(AuthErrorState(e.message.toString()));
  //   }
  // }

  void loggedOut() async {
    await _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
