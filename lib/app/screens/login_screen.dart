import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftwitter/app/cubit/auth/cubit/auth_cubit.dart';
import 'package:ftwitter/app/cubit/cred/cubit/credential_cubit.dart';
import 'package:ftwitter/app/screens/home_screen.dart';
import 'package:ftwitter/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  Widget bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Twitter-like logo or icon

          SizedBox(height: 16.0),
          // Twitter-like text for logging in
          Text(
            'Log in to Twitter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          SizedBox(height: 16.0),
          // Email Input
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          SizedBox(height: 16.0),
          // Password Input
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 32.0),
          // Login Button
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<CredentialCubit>(context).signInUser(
                email: _emailController.text,
                password: _passwordController.text,
              );

              setState(() {
                isLoading = true;
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Twitter-like color
            ),
            child: (!isLoading)
                ? Text('Log in') // Twitter-like text
                : CircularProgressIndicator(),
          ),
          SizedBox(height: 16.0),
          // Register Link
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(PageConst.signUpPage);
            },
            child: Text(
              'Sign up for Twitter',
              style: TextStyle(
                color: Colors.blue, // Twitter-like color
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (ctx, state) {
          if (state is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }

          if (state is CredentialFailure) {
            print('Something went wrong');
          }
        },
        builder: (ctx, state) {
          if (state is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (ctx, authState) {
                if (authState is AuthUserAuthenticated) {
                  return HomeScreen(uid: authState.uid);
                }
                return bodyWidget();
              },
            );
          }

          return bodyWidget();
        },
      ),
    );
  }
}
