import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/UI/firestore/firestore_list_screen.dart';
import 'package:firebase_project/UI/firestore/google_homepage.dart';
import 'package:firebase_project/UI/homepage.dart';
import 'package:firebase_project/UI/round_button.dart';
import 'package:firebase_project/UI/sign_up.dart';
import 'package:firebase_project/UI/upload_image.dart';
import 'package:firebase_project/Utils/utils.dart';
import 'package:firebase_project/auth/forgot_password.dart';
import 'package:firebase_project/auth/login_with_phone.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/auth/post_data/googleauth_services.dart';



class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  bool loading=false;
  final _formkey=GlobalKey<FormState>();
 
  final Emailtextcontroller=TextEditingController();
  final Passwordtextcontroller=TextEditingController();
  final _auth=FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Emailtextcontroller.dispose();
    Passwordtextcontroller.dispose();
  }
  void login(){
    setState(() {
      loading=true;
    });
   _auth.signInWithEmailAndPassword(
    email: Emailtextcontroller.text.toString(), 
    password:Passwordtextcontroller.text.toString()).then((value){
       Utils().toastMessage(value.user!.email.toString());
       Navigator.push(context, MaterialPageRoute(builder: (context)=>const homePage()));
       setState(() {
         loading=false;
       });

    }).onError((error, stackTrace){
        debugPrint(error.toString());
        Utils().toastMessage(error.toString());
        setState(() {
          loading=false;
        });

    });
    
  }
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('images/login.png',),fit: BoxFit.cover),
      ),
      child: Scaffold(
         resizeToAvoidBottomInset : false,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            
            children: [
              Container(
                padding: const EdgeInsets.only(left: 35,top: 140),
                child: const Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 38,fontFamily: 'Poppins-Light'),),
              ),
              Container(
                // padding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.5,
                padding: const EdgeInsets.only(top: 322,
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
                          keyboardType: TextInputType.emailAddress,
                      controller: Emailtextcontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          fontFamily: 'Poppins-Bold'
                        ),
                        suffixIcon: const Icon(Icons.email),
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
                    const SizedBox(height: 12),
        
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: Passwordtextcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Password',
                         hintStyle: const TextStyle(
                          fontFamily: 'Poppins-Bold',
                         
                        ),
                        suffixIcon: const Icon(Icons.visibility_outlined),
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
                   
                    const SizedBox(height:28),
                    
                   RoundButton(title: "Login",
                   loading: loading,
                    onPressed:(){
                    
                     
                    if(_formkey.currentState!.validate()){
        
                     login();
                    }
                   }),
                  
                   Align(
                    alignment: Alignment.bottomRight,
                     child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPass()));
                     }, 
                     child:const Text("Forgot Password ?")),
                   ),
                
                  //  InkWell(
                  //   onTap: (){
                  //     Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginWithPhone()));
                  //   },
                  //    child: Container(
                  //     height: 50,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(50),
                  //       border: Border.all(color: Colors.black)
                  //     ),
                  //     child:Center(
                  //     child: Text("Sign in with google",style: TextStyle(fontFamily: 'Poppins'),),
                  //    ),
                  //    ),
                  //  ),
                   InkWell( 
                    onTap: () async{
                      setState(() {
                        loading=true;
                      });
                       FirebaseService service = new FirebaseService();
          try {
           await service.signInwithGoogle();
           Navigator.push(context, MaterialPageRoute(builder: (context)=>const homePage()));
          
          } catch(e){
            if(e is FirebaseAuthException){
              Utils().toastMessage(e.toString());
            }
          }
          setState(() {
            loading = false;
          });
                      
                    },
                     child: Container(
                       height: 50,
                       
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                          // border: Border.all(color: Colors.black),
                         border: Border.all(color: Colors.black),
                         
                      ),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                                       
                        children: [
                           Container(
                        height: 30.0,
                        width: 35.0,
                        decoration: const BoxDecoration(
                           
                          image: DecorationImage(
                              image:
                                  AssetImage('images/google.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                          
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text("Sign in with Google",style: TextStyle(fontFamily: 'Poppins-Med'),),
                        ],
                       ),
                     ),
                   ),
                   const SizedBox(height: 16,),
                  // 
                   Container(
                     height: 50,
                     width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black),
                          
                        ),
                        
                     child: FloatingActionButton.extended(
                      label: Text("Phone Authentication",style: TextStyle(color: Colors.black,fontFamily: 'Poppins-Med',fontSize: 13),),
                      icon: Icon(Icons.phone_android,size:24.0,color: Colors.black,),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginWithPhone()));
                      }),
                   ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                      const Text("don't have an account ? ",style: TextStyle(fontFamily: 'Poppins-Light'),),
                      TextButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUp()));
                      }, child: const Text("sign up ",style:TextStyle(color:Colors.blue,fontWeight: FontWeight.w500,fontFamily: 'Poppins-Bold')))
                    ],
                   ),
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