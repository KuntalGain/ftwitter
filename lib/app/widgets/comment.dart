import 'package:flutter/material.dart';
import 'package:ftwitter/domain/entities/comment/comment_entity.dart';

Widget commentCard({required CommentEntity comment}) {
  return Container(
    padding: EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          comment.username.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4.0),
        Text(comment.description.toString()),
        SizedBox(height: 8.0),
        Row(
          children: [
            Icon(
              Icons.favorite_outline,
              color: Colors.red,
            ),
            SizedBox(width: 4.0),
            Text(comment.likes!.length.toString()),
            SizedBox(width: 16.0),
            TextButton(
              onPressed: () {
                // Handle reply button tap
              },
              child: Text('Reply'),
            ),
          ],
        ),
      ],
    ),
  );
}
