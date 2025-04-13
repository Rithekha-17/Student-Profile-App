import 'package:flutter/material.dart';
import 'package:practice/add_student.dart';
import 'package:practice/view_data.dart';
import 'package:practice/login_admin.dart';
import 'package:practice/choose_user.dart';
import 'package:practice/post_page.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: Text('Admin Account',
            style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddStudent()));
              },
              child: Text(
                'Add Student Details',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.yellow,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ViewData()));
              },
              child: Text(
                'Show Student Details',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.yellow,
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostPage()));
              },
              child: Text(
                'Post Announcement',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Colors.yellow,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: Colors.yellow,
            ),
            label: 'Home',
          ),
          //NavigationDestination(icon: Badge(child:Icon(Icons.grade,color:Colors.yellow,)),label:'Marks'),
          NavigationDestination(
            icon: Icon(
              Icons.logout,
              color: Colors.yellow,
            ),
            label: 'LogOut',
          ),
        ],
        backgroundColor: Colors.grey[600],
        onDestinationSelected: (int index) {
          setState(
            () {
              _selectedIndex = index;

              if (_selectedIndex == 1)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHome()),
                );
              if (_selectedIndex == 2)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseUserScreen()),
                );

              //Navigator.pushNamed(context,'/quotes');
            },
          );
        },
      ),
    );
  }
}
