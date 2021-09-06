import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseService extends StatefulWidget {
  const FirebaseService({Key? key}) : super(key: key);

  @override
  _FirebaseServiceState createState() => _FirebaseServiceState();
}

class _FirebaseServiceState extends State<FirebaseService> {
  Future<void> addUser() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .add({'name': "Richard"})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  getUser() {
    CollectionReference hostref =
        FirebaseFirestore.instance.collection('hostUrls');
    hostref.get().then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Center(
                child: ListView(
                  children: snapshot.data!.docs.map((user) {
                    return ListTile(title: Text(user['name']));
                  }).toList(),
                ),
              );
            }),
      ),
    );
  }
}
