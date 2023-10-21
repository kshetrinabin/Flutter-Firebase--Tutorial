import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/UI/round_button.dart';
import 'package:firebase_project/Utils/utils.dart';
import 'package:firebase_project/auth/verify_code.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading=false;
  final phonecontroller=TextEditingController();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login With Phone"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          
          children: [
      
            SizedBox(height: 50),
            TextFormField(
              controller: phonecontroller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '+9779809776565'
              ),
      
            ),
            SizedBox(height: 30),

            RoundButton(title: 'Login',loading: loading, onPressed:(){

              
              setState(() {
                loading=true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phonecontroller.text,
                verificationCompleted: (_){
                  setState(() {
                loading=false;
              });
      
              }, verificationFailed:(e){
                setState(() {
                loading=false;
              });
                Utils().toastMessage(e.toString());
              }, codeSent:(String verificationId, int?token){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyCode(verificationId:verificationId ,)));
                setState(() {
                  loading=false;
                });
              }, 
              codeAutoRetrievalTimeout:(e){
               
                Utils().toastMessage(e.toString());
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