import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:practice/admin_home.dart';
import 'package:practice/signup_admin.dart';

class AdminLogin extends StatelessWidget {
  const AdminLogin({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue[850],
        appBar: AppBar(
          title: Text(
            'Admin Login',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.grey,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: A_LoginForm(),
        ),
      ),
    );
  }
}

class A_LoginForm extends StatefulWidget {
  const A_LoginForm({Key? key});

  @override
  State<A_LoginForm> createState() => _A_LoginFormState();
}

class _A_LoginFormState extends State<A_LoginForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('admin_users');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Check if the admin user exists in the database
      DatabaseEvent databaseEvent =
      await _database.child(userCredential.user!.uid).once();

      if (databaseEvent.snapshot.value != null) {
        // Admin user exists, navigate to AdminHomePage
        _showErrorDialog('Login Successful !');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()),
        );
      } else {
        // Admin user does not exist, handle authentication failure
        // Show an error message or perform other actions
        _showErrorDialog('Admin authentication failed');
      }

    } catch (e) {
      print(e.toString());
      // Show an error dialog
      _showErrorDialog('An error occurred during login');
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _login,
          child: Text(
            'Login',
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
        const SizedBox(height: 20.0),

        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => A_SignUpPage()));
          },
          child: const Text('Don\'t have an Account? Sign Up',
              style: TextStyle(
                fontSize: 18,
                color:Colors.yellow,
              )),
        ),
      ],
    );
  }
}

