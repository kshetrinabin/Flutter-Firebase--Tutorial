import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/UI/round_button.dart';
import 'package:firebase_project/Utils/utils.dart';
import 'package:flutter/material.dart';
class addPost extends StatefulWidget {
  const addPost({super.key});

  @override
  State<addPost> createState() => _addPostState();
}

class _addPostState extends State<addPost> {

  final postcontroller = TextEditingController();
  final namecontroller =TextEditingController();
  bool loading=false;
  final databaseref = FirebaseDatabase.instance.ref('data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post data Screen"),
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
              databaseref.child(id).set({

                'short-describe':postcontroller.text.toString(),
                'name':namecontroller.text.toString(),
                'id':id,
            }).then((value){
              setState(() {
                loading=false;
              });
                Utils().toastMessage('Post added');
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