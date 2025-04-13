import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:practice/login_student.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Student Sign Up',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue[600],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: A_SignUpForm(),
        ),
      ),
    );
  }
}

class A_SignUpForm extends StatefulWidget {
  const A_SignUpForm({Key? key});

  @override
  State<A_SignUpForm> createState() => _A_SignUpFormState();
}

class _A_SignUpFormState extends State<A_SignUpForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('student_users');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  Future<void> _signUp() async {
    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        // Create a new account
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Store additional admin details in the database
        await _database.child(_auth.currentUser!.uid).set({
          'email': _emailController.text,
          'pass': _passwordController.text,
          // Add more fields as needed
        });

        // Navigate to login_admin page after successful signup
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentLogin()),
        );
      } else {
        // Handle password mismatch
        // You can show an error message or perform other actions
      }
    } catch (e) {
      // Handle signup errors
      print(e.toString());
      // You can show an error message or perform other actions
    }
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
        TextFormField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(labelText: 'Confirm Password'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _signUp,
          child: Text('Sign Up'),
        ),

      ],
    );
  }
}
