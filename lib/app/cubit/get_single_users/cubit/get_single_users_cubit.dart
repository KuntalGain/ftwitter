import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ftwitter/domain/entities/user/user_entity.dart';
import 'package:ftwitter/domain/usecases/auth/user/get_single_user_usecase.dart';

part 'get_single_users_state.dart';

class GetSingleUsersCubit extends Cubit<GetSingleUsersState> {
  final SingleUserUsecase singleUserUsecase;
  GetSingleUsersCubit({required this.singleUserUsecase})
      : super(GetSingleUsersInitial());

  Future<void> getSingleUsers({required String uid}) async {
    emit(GetSingleUsersLoading());
    try {
      final streamResponse = singleUserUsecase.call(uid);

      streamResponse.listen((users) {
        emit(GetSingleUsersLoaded(user: users.first));
      });
    } on SocketException catch (_) {
      emit(GetSingleUsersFailure());
    } catch (_) {
      emit(GetSingleUsersFailure());
    }
  }
}
