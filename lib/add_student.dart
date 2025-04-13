import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:practice/view_data.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AddStudent> {
  final _formkey = GlobalKey<FormState>();
  late DatabaseReference _ref;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _cgpaController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.ref().child("Students");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Student Details"),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://www.ssn.edu.in/wp-content/uploads/2019/12/image-2.jpg'), // Replace with your image URL
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Center(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter Student Name",
                        hintStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter Student Name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      controller: _idController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter Student ID",
                        hintStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter Student ID";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      controller: _mobileController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter Mobile Number",
                        hintStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter Mobile Number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      controller: _emailController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter emailId";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      controller: _cgpaController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter CGPA",
                        hintStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter CGPA";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      controller: _yearController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter Year of Study",
                        hintStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter Year of Study";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    TextFormField(
                      controller: _departmentController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter Department",
                        hintStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Enter Department";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (!_formkey.currentState!.validate()) {
                              return;
                            }
                            _formkey.currentState!.save();
                            Map<String, dynamic> studentDetails = {
                              "name": _nameController.text,
                              "id": _idController.text,
                              "email": _emailController.text,
                              "mobile": _mobileController.text,
                              "cgpa": _cgpaController.text,
                              "year": _yearController.text,
                              "department": _departmentController.text,
                            };
                            _ref
                                .push()
                                .set(studentDetails)
                                .then((value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const ViewData())));
                          },
                          child: const Text("Add Student"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ViewData()));
                          },
                          child: const Text("View Data"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _formkey.currentState!.reset();
                          },
                          child: const Text("Reset"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
