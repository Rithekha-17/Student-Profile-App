import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class StudentHome extends StatefulWidget {
  final String currentUserEmail;

  const StudentHome({Key? key, required this.currentUserEmail})
      : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  late DatabaseReference _ref;
  Map<String, dynamic>? studentProfile;
  List<Map<String, dynamic>> announcements = [];

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.ref(); // Pointing to the root

    // Fetch student profile details using the email
    _ref
        .child("Students") // Targeting the Students node
        .orderByChild("email")
        .equalTo(widget.currentUserEmail)
        .once()
        .then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> studentsData =
            snapshot.value as Map<dynamic, dynamic>;

        // Find the student with the correct email
        String studentKey = studentsData.keys.firstWhere(
          (key) => studentsData[key]["email"] == widget.currentUserEmail,
          orElse: () => "",
        );

        if (studentKey.isNotEmpty) {
          setState(() {
            // Access the nested data using the specific key
            studentProfile =
                Map<String, dynamic>.from(studentsData[studentKey]);
          });
        }
      }

      // Fetch announcements
      _ref
          .child("Posts")
          .orderByChild("timestamp")
          .once()
          .then((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.value != null) {
          Map<dynamic, dynamic> postsData =
              snapshot.value as Map<dynamic, dynamic>;

          // Convert the map to a list of announcements
          announcements =
              postsData.values.toList().cast<Map<String, dynamic>>();
          announcements
              .sort((a, b) => b["timestamp"].compareTo(a["timestamp"]));

          // Trigger a rebuild
          setState(() {});
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Profile"),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (studentProfile != null)
              ProfileCard(studentProfile: studentProfile!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _seeAnnouncements,
              child: Text(
                'See Announcements',
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

 void _seeAnnouncements() async {
  print("Fetching announcements...");
  try {
    DatabaseEvent event = await _ref.child("Posts").orderByChild("timestamp").once();

    if (event.snapshot.value != null) {
      Map<dynamic, dynamic> postsData = event.snapshot.value as Map<dynamic, dynamic>;

      // Convert the map to a list of announcements
      announcements = postsData.entries
          .map((entry) => Map<String, dynamic>.from(entry.value as Map))
          .toList();
      announcements.sort(
          (a, b) => (b["timestamp"] as int).compareTo(a["timestamp"]));

      // Print the announcements
      print("Announcements fetched successfully: $announcements");

      // Trigger a rebuild
      setState(() {
        print("Displaying announcements...");
        _showAnnouncementsBottomSheet();
      });
    } else {
      print("No announcements found.");
    }
  } catch (error) {
    print("Error fetching announcements: $error");
  }
}


  void _showAnnouncementsBottomSheet() {
    if (announcements.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemCount: announcements.length,
            itemBuilder: (BuildContext context, int index) {
              return AnnouncementTile(announcement: announcements[index]);
            },
          );
        },
      );
    } else {
      print("No announcements to display.");
    }
  }
}

class AnnouncementTile extends StatelessWidget {
  final Map<String, dynamic> announcement;

  const AnnouncementTile({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        announcement["announcement"],
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        "Posted on: ${_formatTimestamp(announcement["timestamp"])}",
      ),
      tileColor: Colors.grey[200],
    );
  }

  String _formatTimestamp(int timestamp) {
    // Format timestamp as per your requirement
    // This is a simple example, you might want to use a package like `intl` for more sophisticated formatting
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
  }
}

class ProfileCard extends StatelessWidget {
  final Map<String, dynamic> studentProfile;

  const ProfileCard({Key? key, required this.studentProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                studentProfile["name"],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(studentProfile["email"]),
            ),
            Divider(),
            ListTile(
              title: Text("ID: ${studentProfile["id"]}"),
              subtitle: Text("Department: ${studentProfile["department"]}"),
            ),
            ListTile(
              title: Text("Year: ${studentProfile["year"]}"),
              subtitle: Text("CGPA: ${studentProfile["cgpa"]}"),
            ),
            ListTile(
              title: Text("Mobile: ${studentProfile["mobile"]}"),
            ),
          ],
        ),
      ),
    );
  }
}
