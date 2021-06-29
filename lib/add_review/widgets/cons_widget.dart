import 'package:flutter/material.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetSecond.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class ConsWidget extends StatefulWidget{
  TextEditingController consTextController = TextEditingController();
  @override
  State<StatefulWidget> createState() {
    return ConsWidgetState();
  }
}

class ConsWidgetState extends State<ConsWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            controller: widget.consTextController,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorClass.greyColor,),
                ),
                fillColor: Colors.white,
            )),
          Align(
            alignment: Alignment.topRight,
            child: TextButton.icon(onPressed: (){
              globalKey.currentState.textfieldListCons.add(ConsWidget());
              globalKey.currentState.setState(() {

              });

            }, icon: Icon(Icons.add), label: Text("Add More",
              style: TextStyle(color: ColorClass.blueColor,fontSize: 15),)),
          ),

        ],
      ),
    );
  }
}