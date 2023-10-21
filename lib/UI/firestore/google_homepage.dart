import 'package:firebase_project/UI/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Google Home Page"),
            centerTitle: true,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () async {
                    await _googleSignIn.signOut();
                    await _auth.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyLogin()));
                  },
                  icon: Icon(Icons.logout)),
            ]),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 2,
                shadowColor: Colors.pink.shade600,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoURL!),
                    radius: 20,
                  ),
                  title: Text(user!.displayName!),
                  subtitle: Text(user!.email!),
                ),
              )
            ],
          ),
        )));
  }
}
