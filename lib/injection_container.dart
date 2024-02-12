import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ftwitter/app/cubit/auth/cubit/auth_cubit.dart';
import 'package:ftwitter/app/cubit/comment/cubit/comment_cubit.dart';
import 'package:ftwitter/app/cubit/cred/cubit/credential_cubit.dart';
import 'package:ftwitter/app/cubit/get_single_users/cubit/get_single_users_cubit.dart';
import 'package:ftwitter/app/cubit/post/cubit/post_cubit.dart';
import 'package:ftwitter/app/cubit/user/cubit/user_cubit.dart';
import 'package:ftwitter/data/datasource/remote_datasource/remote_data_source.dart';
import 'package:ftwitter/data/datasource/remote_datasource/remote_data_source_impl.dart';
import 'package:ftwitter/data/repos/supabase_repository_impl.dart';
import 'package:ftwitter/domain/repos/supabase_repository.dart';
import 'package:ftwitter/domain/usecases/auth/user/create_user_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/get_current_uid_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/get_single_user_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/get_user_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/is_signin_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/signin_user_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/signout_user_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/signup_user_usecase.dart';
import 'package:ftwitter/domain/usecases/auth/user/update_user_usecase.dart';
import 'package:ftwitter/domain/usecases/comment/create_comment_usecase.dart';
import 'package:ftwitter/domain/usecases/comment/delete_comment_usecase.dart';
import 'package:ftwitter/domain/usecases/comment/like_comment_usecase.dart';
import 'package:ftwitter/domain/usecases/comment/read_comment_usecase.dart';
import 'package:ftwitter/domain/usecases/comment/update_comment_usecase.dart';
import 'package:ftwitter/domain/usecases/post/create_post_usecase.dart';
import 'package:ftwitter/domain/usecases/post/delete_post_usecase.dart';
import 'package:ftwitter/domain/usecases/post/fetch_post_usecase.dart';
import 'package:ftwitter/domain/usecases/post/like_post_usecase.dart';
import 'package:ftwitter/domain/usecases/post/update_post_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // cubits
  sl.registerFactory(
    () => AuthCubit(
      signOutUserUsecase: sl.call(),
      isSignInUsecase: sl.call(),
      getCurrentUidUsecase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => CredentialCubit(
      signInUserUsecase: sl.call(),
      signUpUserUsecase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => UserCubit(
      updateUserUsecase: sl.call(),
      getUserUsecase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => GetSingleUsersCubit(
      singleUserUsecase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => PostCubit(
      createPostUsecase: sl.call(),
      updatePostUsecase: sl.call(),
      deletePostUsecase: sl.call(),
      fetchPostUsecase: sl.call(),
      likePostUsecase: sl.call(),
    ),
  );

  sl.registerFactory(
    () => CommentCubit(
      commentUsecase: sl.call(),
      deleteCommentUsecase: sl.call(),
      likeCommentUsecase: sl.call(),
      readCommentsUseCase: sl.call(),
      updateCommentUsecase: sl.call(),
    ),
  );

  // Use Cases

  sl.registerLazySingleton(() => CreateUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SingleUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignOutUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUsecase(repository: sl.call()));

  sl.registerLazySingleton(() => CreatePostUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdatePostUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => DeletePostUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => LikePostUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => FetchPostUsecase(repository: sl.call()));

  sl.registerLazySingleton(() => CreateCommentUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => DeleteCommentUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => LikeCommentUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => ReadCommentsUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateCommentUsecase(repository: sl.call()));

  // Repository

  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataImpl(
          firebaseFirestore: sl.call(), firebaseAuth: sl.call()));

  // Externals

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
}
