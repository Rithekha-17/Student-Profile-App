import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:practice/update_data.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key}) : super(key: key);

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref().child("Students");
    return Scaffold(
      appBar: AppBar(title: const Text("View Students")),
      body: FirebaseAnimatedList(
        query: ref,
        itemBuilder: (context, snapshot, animation, index) {
          if (snapshot.value is Map) {
            final data = Map<String, dynamic>.from(snapshot.value as Map);
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: Colors.indigo[100],
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          ref.child(snapshot.key!).remove();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              // ignore: unnecessary_new
                              builder: (context) => new UpdateScreen(
                                value: snapshot.key!,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.update,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ${data['name'] ?? 'N/A'}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "ID: ${data['id'] ?? 'N/A'}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Mobile: ${data['mobile'] ?? 'N/A'}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "CGPA: ${data['cgpa'] ?? 'N/A'}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Year: ${data['year'] ?? 'N/A'}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "Department: ${data['department'] ?? 'N/A'}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            // Handle the case where snapshot.value is not a Map
            return Container();
          }
        },
      ),
    );
  }
}
