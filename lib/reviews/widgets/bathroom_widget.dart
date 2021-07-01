import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class BathRoomWidget extends StatelessWidget{

  String bathRoom;
  BathRoomWidget(this.bathRoom);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FittedBox(fit: BoxFit.fitWidth,
        child: Row(
          children: [
            // Icon(Icons.bathtub_outlined,size: 18,),
            AutoSizeText(
                "Bath Rooms : ",
                style:  TextStyle(
                    color:  ColorClass.darkTextColor,
                    fontWeight: FontWeight.w700,
                    fontStyle:  FontStyle.normal,
                    fontSize: 14.0
                ),
                textAlign: TextAlign.left
            ),
            AutoSizeText(
                bathRoom,
                style:  TextStyle(
                    color:Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontStyle:  FontStyle.normal,
                    fontSize: 12.0
                ),
                textAlign: TextAlign.left
            ),
          ],
        ),
      ),
    );
  }
}