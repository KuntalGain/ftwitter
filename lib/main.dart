import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftwitter/app/cubit/auth/cubit/auth_cubit.dart';
import 'package:ftwitter/app/cubit/comment/cubit/comment_cubit.dart';
import 'package:ftwitter/app/cubit/cred/cubit/credential_cubit.dart';
import 'package:ftwitter/app/cubit/get_single_users/cubit/get_single_users_cubit.dart';
import 'package:ftwitter/app/cubit/post/cubit/post_cubit.dart';
import 'package:ftwitter/app/cubit/user/cubit/user_cubit.dart';
import 'package:ftwitter/app/screens/add_tweet.dart';
import 'package:ftwitter/app/screens/home_screen.dart';
import 'package:ftwitter/app/screens/login_screen.dart';
import 'package:ftwitter/app/screens/register_screen.dart';
import 'package:ftwitter/app/widgets/on_generate_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ftwitter/constant.dart';
import 'package:ftwitter/firebase_options.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..authInitial(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUsersCubit>()),
        BlocProvider(create: (_) => di.sl<PostCubit>()),
        BlocProvider(create: (_) => di.sl<CommentCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: '/',
        routes: {
          '/': (ctx) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is AuthUserAuthenticated) {
                  return HomeScreen(uid: authState.uid);
                }

                return RegisterScreen();
              },
            );
          },
          PageConst.signInPage: (ctx) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is AuthUserAuthenticated) {
                  return HomeScreen(uid: authState.uid);
                }
                return LoginScreen();
              },
            );
          },
        },
      ),
    );
  }
}
