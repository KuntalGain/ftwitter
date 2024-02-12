import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ftwitter/domain/usecases/auth/user/get_current_uid_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/is_signin_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/signout_user_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignOutUserUsecase signOutUserUsecase;
  final IsSignInUsecase isSignInUsecase;
  final GetCurrentUidUsecase getCurrentUidUsecase;

  AuthCubit({
    required this.signOutUserUsecase,
    required this.isSignInUsecase,
    required this.getCurrentUidUsecase,
  }) : super(AuthInitial());

  Future<void> authInitial(BuildContext context) async {
    try {
      bool isSignin = await isSignInUsecase.call();

      if (isSignin == true) {
        final uid = await getCurrentUidUsecase.call();
        emit(AuthUserAuthenticated(uid: uid));
      } else {
        emit(AuthUserNotAuthenticated());
      }
    } catch (_) {
      emit(AuthUserNotAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUsecase.call();
      emit(AuthUserAuthenticated(uid: uid));
    } catch (e) {
      emit(AuthUserNotAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUserUsecase.call();
      emit(AuthUserNotAuthenticated());
    } catch (_) {
      emit(AuthUserNotAuthenticated());
    }
  }
}
