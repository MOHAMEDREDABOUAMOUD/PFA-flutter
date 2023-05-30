import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signin_signup/DAL/dao.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  void saveReportToFirestore(String email, String report) {
    CollectionReference reportsCollection =
        FirebaseFirestore.instance.collection('reports');

    reportsCollection
        .add({
          'email': email,
          'report': report,
          'timestamp': DateTime.now(),
        })
        .then((value) {
          // Report saved successfully
          print('Report saved to Firestore');
          // You can show a success message or navigate to another screen here
        })
        .catchError((error) {
          // An error occurred while saving the report
          print('Error saving report: $error');
          // You can show an error message here
        });
  }

  bool _isVisible = false;
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        title: Text(
          "Make Report",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView( // Wrap the Column widget with SingleChildScrollView
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(
                "Set a Report",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Please Make a Report (hta tbdloha mal9it manktb).",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Your Email',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _reportController, // Add the controller to the TextFormField
                  minLines: 5,
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: 'Enter your Report Here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  String email = _emailController.text;
                  String report = _reportController.text;
                  saveReportToFirestore(email, report);
                },
                child: Text('Save Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}