import 'package:flutter/material.dart';

class SavedTweetsScreen extends StatelessWidget {
  final List<Tweet> savedTweets = [
    Tweet(
      username: 'johndoe',
      name: 'John Doe',
      content: 'Excited to learn Flutter! #Flutter #MobileDev',
      timestamp: '2 hours ago',
      avatarUrl:
          'https://placekitten.com/50/50', // Replace with user's profile picture URL
    ),
    // Add more saved tweets as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Tweets'),
      ),
      body: savedTweets.isEmpty
          ? Center(
              child: Text('No saved tweets.'),
            )
          : ListView.builder(
              itemCount: savedTweets.length,
              itemBuilder: (context, index) {
                return TweetCard(tweet: savedTweets[index]);
              },
            ),
    );
  }
}

class Tweet {
  final String username;
  final String name;
  final String content;
  final String timestamp;
  final String avatarUrl;

  Tweet({
    required this.username,
    required this.name,
    required this.content,
    required this.timestamp,
    required this.avatarUrl,
  });
}

class TweetCard extends StatelessWidget {
  final Tweet tweet;

  TweetCard({required this.tweet});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(tweet.avatarUrl),
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tweet.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      '@${tweet.username} • ${tweet.timestamp}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              tweet.content,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
