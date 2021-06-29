import 'package:flutter/material.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetSecond.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';

class ProsWidget extends StatefulWidget{
  TextEditingController prosTextController = new TextEditingController();
  @override
  State<StatefulWidget> createState() {
    return ProsWidgetState();
     }
}

class ProsWidgetState extends State<ProsWidget>{


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            controller: widget.prosTextController,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:  ColorClass.greyColor,),
                ),
                fillColor: Colors.white,
            ),onEditingComplete: (){
              globalKey.currentState.textfieldListPros.add(ProsWidget());
              globalKey.currentState.setState(() {

              });
            },),
          Align(
            alignment: Alignment.topRight,
            child: TextButton.icon(onPressed: (){
              globalKey.currentState.textfieldListPros.add(ProsWidget());
              globalKey.currentState.setState(() {

              });

            }, icon: Icon(Icons.add), label: Text("Add More",
              style: TextStyle(color: ColorClass.blueColor,fontSize: 15),)),
          ),

          // GestureDetector(
          //     behavior: HitTestBehavior.translucent,
          //     onTap: (){
          //      globalKey.currentState.textfieldListPros.add(ProsWidget());
          //      globalKey.currentState.setState(() {
          //
          //      });
          //     },
          //     child: Container(alignment: Alignment.centerRight,child: Text("+ Add More",
          //       style: TextStyle(color: ColorClass.blueColor,fontSize: 20),)))
        ],
      ),
    );
  }
}