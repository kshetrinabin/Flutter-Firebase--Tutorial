import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool loading;
  const RoundButton({super.key,required this.title,required this.onPressed,this.loading=false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 45,
        width: 400,
        child: Center(child:loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,): Text(title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Poppins-Med',letterSpacing: 1.0),)),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}