

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/UI/homepage.dart';
import 'package:firebase_project/UI/round_button.dart';
import 'package:firebase_project/Utils/utils.dart';
import 'package:flutter/material.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({super.key,required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
 bool loading=false;
  final verifycodecontroller=TextEditingController();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify Phone"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          
          children: [
      
            SizedBox(height: 50),
            TextFormField(
              controller: verifycodecontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '6 digit code'
              ),
      
            ),
            SizedBox(height: 30),

            RoundButton(title: 'Verify',loading: loading, onPressed:()async{

              setState(() {
                loading=true;
              });
              final credential=PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: verifycodecontroller.text.toString());

                try{

                  await auth.signInWithCredential(credential);

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

                }
                catch(e){
                  Utils().toastMessage(e.toString());
                  setState(() {
                    loading=false;
                  });
                }
              setState(() {
                loading=true;
              });
            }),
      
        ],
          
        ),
      ),
    );
  }
}