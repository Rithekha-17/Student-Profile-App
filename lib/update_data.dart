import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:practice/view_data.dart';

class UpdateScreen extends StatefulWidget {
  final String value;
  // ignore: use_key_in_widget_constructors
  const UpdateScreen({required this.value});

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  // Use Map to store updated values for different fields
  Map<String, String> updatedFields = {
    "name": "",
    "id": "",
    "mobile": "",
    "cgpa": "",
    "year": "",
    "department": "",
  };

  final _formkey = GlobalKey<FormState>();
  final _ref = FirebaseDatabase.instance.ref().child("Students");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                // TextFormFields for each field you want to update
                buildTextField("Name", "name"),
                buildTextField("ID", "id"),
                buildTextField("Mobile", "mobile"),
                buildTextField("CGPA", "cgpa"),
                buildTextField("Year", "year"),
                buildTextField("Department", "department"),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!_formkey.currentState!.validate()) {
                      return;
                    }
                    _formkey.currentState!.save();

                    // Update each field in the database
                    updatedFields.forEach((key, value) {
                      if (value.isNotEmpty) {
                        _ref.child(widget.value).child(key).set(value);
                      }
                    });

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ViewData()));
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build TextFormFields
  Widget buildTextField(String labelText, String fieldName) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: "Enter Updated $labelText",
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "Enter Updated $labelText";
        }
        return null;
      },
      onSaved: (value) {
        updatedFields[fieldName] = value!;
      },
    );
  }
}
