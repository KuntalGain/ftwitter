part of 'get_single_users_cubit.dart';

abstract class GetSingleUsersState extends Equatable {
  const GetSingleUsersState();
}

class GetSingleUsersInitial extends GetSingleUsersState {
  @override
  List<Object> get props => [];
}

class GetSingleUsersLoading extends GetSingleUsersState {
  @override
  List<Object> get props => [];
}

class GetSingleUsersLoaded extends GetSingleUsersState {
  final UserEntity user;

  GetSingleUsersLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class GetSingleUsersFailure extends GetSingleUsersState {
  @override
  List<Object> get props => [];
}
