import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/UI/round_button.dart';
import 'package:firebase_project/Utils/utils.dart';

class addFirestoredata extends StatefulWidget {
  const addFirestoredata({super.key});

  @override
  State<addFirestoredata> createState() => _addFirestoredataState();
}

class _addFirestoredataState extends State<addFirestoredata> {

  final postcontroller = TextEditingController();
  final namecontroller =TextEditingController();
  bool loading=false;
  final firestoredb=FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Firestore data"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding:EdgeInsets.symmetric(horizontal: 15,vertical: 20),
       
        child: Column(
          
          children: [
            SizedBox(height: 5),
            TextFormField(
              controller: namecontroller,
              decoration: InputDecoration(
                hintText: 'Name of your friend',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: postcontroller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter any describe',
                border:OutlineInputBorder(),
                
              ),
            ),
            SizedBox(height: 20),
            RoundButton(title: 'Add Post',loading: loading ,onPressed: (){
              setState(() {
                loading=true;
              });
               String id=DateTime.now().microsecondsSinceEpoch.toString();
              firestoredb.doc(id).set({
                'id':id,
                'name':namecontroller.text.toString(),
                'short-describe':postcontroller.text.toString()
                

              }).then((value){
                setState(() {
                  loading=false;
                });
                Utils().toastMessage("Post Added");
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
                setState(() {
                  loading=false;
                });
              });
             
            }),
          ],
        ),
      ),
    );
  }
}