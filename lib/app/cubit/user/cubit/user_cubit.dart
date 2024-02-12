import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ftwitter/domain/entities/user/user_entity.dart';
import 'package:ftwitter/domain/usecases/auth/user/get_user_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUsecase updateUserUsecase;
  final GetUserUsecase getUserUsecase;

  UserCubit({required this.updateUserUsecase, required this.getUserUsecase})
      : super(UserInitial());

  Future<void> getUsers({required UserEntity user}) async {
    emit(UserLoading());
    try {
      final streamResponse = getUserUsecase.call(user);

      streamResponse.listen((users) {
        emit(UserLoaded(users: users));
      });
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUsers({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await updateUserUsecase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
