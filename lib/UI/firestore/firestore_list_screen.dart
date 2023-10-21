
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/UI/firestore/add_firestore_data.dart';

import 'package:flutter/material.dart';

class listScreen extends StatefulWidget {
  const listScreen({super.key});

  @override
  State<listScreen> createState() => _listScreenState();
}

class _listScreenState extends State<listScreen> {
   final firestoredb=FirebaseFirestore.instance.collection("users").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore List Screen"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: firestoredb,
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.connectionState  == ConnectionState.waiting)
            return CircularProgressIndicator();
            if(snapshot.hasError)
            return Text("some errors occur");

            return Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,Index){
              return ListTile(
                title: Text(snapshot.data!.docs[Index]['name'].toString()),
                subtitle: Text(snapshot.data!.docs[Index]['short-describe'].toString()),
              );
            }),
          );
          }),
          
        ],
      ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>addFirestoredata()) );
         },
         
         child: Icon(Icons.add),
         ),
         
    );
    
  }
}