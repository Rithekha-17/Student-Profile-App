import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class PostPage extends StatelessWidget {
  final TextEditingController _announcementController = TextEditingController();

  void _postAnnouncement() {
    String announcement = _announcementController.text;

    if (announcement.isNotEmpty) {
      DatabaseReference postsRef =
          FirebaseDatabase.instance.ref().child("Posts");

      // Generate a unique key for each announcement
      String postId = postsRef.push().key ?? "";

      // Save the announcement to the "Posts" node
      postsRef.child(postId).set({
        'announcement': announcement,
        'timestamp': ServerValue.timestamp,
      });

      // Clear the input field after posting
      _announcementController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Announcement'),
        backgroundColor: Colors.grey[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _announcementController,
              decoration: InputDecoration(
                hintText: 'Enter your announcement...',
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _postAnnouncement,
              child: Text(
                'Post',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
