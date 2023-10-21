import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/UI/round_button.dart';
import 'package:firebase_project/Utils/utils.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  bool loading= false;
  final FpasswordController = TextEditingController();
  final auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password Screen"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          
          children: [
            SizedBox(height: 30),
            TextField(
              controller: FpasswordController,
              decoration: InputDecoration(
                hintText: 'Enter email',
                border: OutlineInputBorder(
                  
                )
              ),
            ),
            SizedBox(height: 35),
            RoundButton(title: 'Login',loading: loading, onPressed:(){
              setState(() {
                loading=true;
              });
              auth.sendPasswordResetEmail(email: FpasswordController.text.toString()).then((value){
                
                Utils().toastMessage('The Reset Password link has been sent in your email');
                setState(() {
                  loading=false;
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