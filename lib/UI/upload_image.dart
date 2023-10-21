import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_project/UI/login_page.dart';
import 'package:firebase_project/UI/round_button.dart';
import 'package:firebase_project/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'as firebase_storage;
import 'package:image_picker/image_picker.dart';

class UploadImg extends StatefulWidget {
  const UploadImg({super.key});

  @override
  State<UploadImg> createState() => _UploadImgState();
}

class _UploadImgState extends State<UploadImg> {

  File? _upload_image;
  final picker=ImagePicker();
  bool loading = false;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref('add');
  Future getImage()async{
    final PickedFile= await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    setState(() {
       if(PickedFile!=null){
      _upload_image=File(PickedFile.path);
    }
    else{
      print("no picked fie");
    }
    });
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>MyLogin()));
          }, icon:Icon(Icons.logout)),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple.shade200,
                      width: 3,
                    ),
                  ),
                  child:_upload_image!=null ? Image.file(_upload_image!.absolute):Icon(Icons.upload_file),
                ),
              ),
            ),
            SizedBox(height: 35),
            RoundButton(title: 'Upload',loading: loading, onPressed:()async{
              setState(() {
                
                loading=true;
              });
              firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/kavinroll/'+DateTime.now().microsecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadTask= ref.putFile(_upload_image!.absolute);

               Future.value(uploadTask).then((value)async{
                 var newUrl  = await ref.getDownloadURL();

              databaseReference.child('1').set({
                'id':12345,
                'name':newUrl.toString(),
              }).then((value){
                Utils().toastMessage("Image Uploaded");
                setState(() {
                  loading=false;
                });
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
                setState(() {
                  loading=false;
                });
              });

              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
                setState(() {
                  loading=false;
                });
                
              });
             

            })
          ],
        ),
      ),
    );
  }
}