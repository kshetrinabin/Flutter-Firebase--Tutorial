import 'package:firebase_project/UI/login_page.dart';
import 'package:firebase_project/UI/round_button.dart';
import 'package:firebase_project/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  bool loading=false;
  final _formkey=GlobalKey<FormState>();
  final Emailtextcontroller=TextEditingController();
  final Passwordtextcontroller=TextEditingController();
  final usernametextcontroller=TextEditingController();

  final _auth =FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Emailtextcontroller.dispose();
    Passwordtextcontroller.dispose();
  }
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: const AssetImage('images/register.png',),fit: BoxFit.cover),
      ),
      child: Scaffold(
         resizeToAvoidBottomInset : false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35,top: 125),
                child: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 38,fontFamily: 'Poppins-Light'),),
              ),
              Container(
                padding: EdgeInsets.only(top:300,
                right: 35,
                left: 35
                ),
                child: Column(
                  
                  children: [
                    
                    Form(
                      key:_formkey,
                      child: Column(
                      children: [
                         
        
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller:usernametextcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins-Bold'
                        ),
                        suffixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Enter Username';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  SizedBox(height: 12),

                         TextFormField(
                          keyboardType: TextInputType.emailAddress,
                      controller: Emailtextcontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Email',
                         hintStyle: TextStyle(
                          fontFamily: 'Poppins-Bold'
                        ),
                        suffixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Enter Email';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 12),
        
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: Passwordtextcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Password',
                         hintStyle: TextStyle(
                          fontFamily: 'Poppins-Bold'
                        ),
                        suffixIcon: Icon(Icons.visibility_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return 'Enter Password';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                   
        
                      ],
                    )),
                   
                    SizedBox(height:28),
                    
                   RoundButton(title: "sign up",
                   loading: loading, 
                   onPressed:(){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        
                        loading=true;
                      });
        
                      _auth.createUserWithEmailAndPassword(email: Emailtextcontroller.text.toString(),
                       password: Passwordtextcontroller.text.toString()).then((value){
                        setState(() {
                        
                        loading=false;
                      });
        
                       }).onError((error, stackTrace){
                        Utils().toastMessage(error.toString());
                        setState(() {
                        
                        loading=false;
                      });
        
        
                       });
        
                    }
                   }),
                   SizedBox(height:4),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                      Text("already have an account ? ",style: TextStyle(fontFamily: 'Poppins-Light'),),
                      TextButton(onPressed: (){
                         Navigator.pop(context, MaterialPageRoute(builder: (context)=> MyLogin()));
                      }, child: Text("login here ",style:TextStyle(color:Colors.white,fontWeight: FontWeight.w500,fontFamily: 'Poppins-Bold')))
                    ],
                   )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}