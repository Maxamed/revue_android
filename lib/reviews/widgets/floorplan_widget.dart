import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class FloorPlanWidget extends StatelessWidget{
  String floorPlan = "";

  FloorPlanWidget(this.floorPlan);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(4.0),
      child: FittedBox(fit: BoxFit.fitWidth,
        child: Row(
          children: [
            AutoSizeText(
                "Floor Plan ",
                style:  TextStyle(
                    color:  ColorClass.darkTextColor,
                    fontWeight: FontWeight.w700,
                    fontStyle:  FontStyle.normal,
                    fontSize: 15.0
                ),
                textAlign: TextAlign.left
            ),
            AutoSizeText(
                "$floorPlan sqft",
                style:  TextStyle(
                    color:ColorClass.greyColor,
                    fontWeight: FontWeight.w600,
                    fontStyle:  FontStyle.normal,
                    fontSize: 13.0
                ),
                textAlign: TextAlign.left
            ),
          ],
        ),
      ),
    );
  }
}