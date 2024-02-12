import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ftwitter/app/cubit/get_single_users/cubit/get_single_users_cubit.dart';
import 'package:ftwitter/app/screens/add_tweet.dart';
import 'package:ftwitter/app/screens/feed_screen.dart';
import 'package:ftwitter/app/screens/liked_screen.dart';
import 'package:ftwitter/app/screens/profile_screen.dart';
import 'package:ftwitter/app/screens/search_screen.dart';
import 'package:ftwitter/constant.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  const HomeScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    BlocProvider.of<GetSingleUsersCubit>(context)
        .getSingleUsers(uid: widget.uid);
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUsersCubit, GetSingleUsersState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleUsersLoaded) {
          final currentUser = getSingleUserState.user;
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddTweet(user: currentUser)));
              },
              child: const Icon(Icons.add),
            ),
            // backgroundColor: backGroundColor,
            bottomNavigationBar: CupertinoTabBar(
              // backgroundColor: backGroundColor,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                    ),
                    label: ""),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle_outlined,
                    ),
                    label: ""),
              ],
              onTap: navigationTapped,
            ),
            body: PageView(
              controller: pageController,
              children: [
                // home
                // search
                // likes

                FeedScreen(),
                SearchScreen(),
                SavedTweetsScreen(),
                ProfileScreen(
                  currentUser: currentUser,
                ),
              ],
              onPageChanged: onPageChanged,
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
