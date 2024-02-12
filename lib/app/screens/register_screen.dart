import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftwitter/app/cubit/auth/cubit/auth_cubit.dart';
import 'package:ftwitter/app/cubit/cred/cubit/credential_cubit.dart';
import 'package:ftwitter/app/screens/home_screen.dart';
import 'package:ftwitter/constant.dart';
import 'package:ftwitter/domain/entities/user/user_entity.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, state) {
          if (state is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }

          if (state is CredentialFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Invalid Details'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (ctx, state) {
                if (state is AuthUserAuthenticated) {
                  return HomeScreen(uid: state.uid);
                } else {
                  return bodyWidget();
                }
              },
            );
          }

          return bodyWidget();
        },
      ),
    );
  }

  Widget bodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Twitter-like text for registering
            Text(
              'Create your account',
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
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),

            TextFormField(
              controller: _bioController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Bio',
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
            SizedBox(height: 16.0),
            // Confirm Password Input
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            SizedBox(height: 32.0),
            // Register Button
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<CredentialCubit>(context)
                    .signUpUser(
                  user: UserEntity(
                    email: _emailController.text,
                    password: _passwordController.text,
                    bio: _bioController.text,
                    username: _nameController.text,
                    totalPosts: 0,
                    totalFollowing: 0,
                    totalFollower: 0,
                    name: _nameController.text,
                    followers: [],
                    following: [],
                  ),
                )
                    .then((value) {
                  setState(() {
                    _emailController.clear();
                    _passwordController.clear();
                  });
                });
              },

              child: Text('Next'), // Twitter-like text
            ),
            SizedBox(height: 16.0),
            // Login Link
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PageConst.signInPage);
              },
              child: Text(
                'Already have an account? Log in',
                style: TextStyle(
                  color: Colors.blue, // Twitter-like color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
