import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void displayAlertDialog(BuildContext context,{String title,String content}){
  showDialog(
    context: context,
    builder: (context){
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
      });
    return  AlertDialog(
        title: Text(title,style: TextStyle(color: Colors.black87,fontSize: 15,fontWeight: FontWeight.w600),),
        content: Text(content,style: TextStyle(color: Colors.black87,fontSize: 14,)),
      );
    }
  );

}