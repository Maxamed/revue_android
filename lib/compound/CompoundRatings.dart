import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:revue_mobile/Modal/CompoundModal.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class CompoundRatings extends StatelessWidget{
  CompoundModal compoundModal;
  CompoundRatings(this.compoundModal);
  
 double getRatingPercent(double value){
   double percent = (value*2/10);
   return percent;
  }
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        CircularPercentIndicator(
          radius:40,
          lineWidth:3.5,
          animation: false,
          percent: getRatingPercent(compoundModal.facility),
          center: new Text(
            compoundModal.facility.toStringAsFixed(1),
            style:
            new TextStyle(color: ColorClass.darkTextColor,fontWeight: FontWeight.w700,
                fontSize: 12.0),
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: ColorClass.circularBgColor,
          progressColor:  ColorClass.redColor,
          footer: Padding(
            padding: const EdgeInsets.only(
                top: 8,right: 4),
            child: AutoSizeText(
                "Facilities",
                style:  TextStyle(color: ColorClass.lightTextColor,fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,),
                textAlign: TextAlign.left
            ),
          ) ,
        ),
        CircularPercentIndicator(
          radius:40,
          lineWidth:3.5,

          animation: false,

          percent: getRatingPercent(compoundModal.design),
          center: new Text(
            compoundModal.design.toStringAsFixed(1),
            style:
            new TextStyle(color:  ColorClass.darkTextColor, fontSize: 12.0,fontWeight: FontWeight.w700),
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: ColorClass.circularBgColor,
          progressColor:  ColorClass.blueColor,
          footer:  Padding(
            padding: const EdgeInsets.only(
                top: 8,right: 4),
            child: AutoSizeText(
                "Design",
                style: TextStyle(color: ColorClass.lightTextColor,fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,),
                textAlign: TextAlign.left
            ),
          ),
        ),


        CircularPercentIndicator(
          radius:40,
          lineWidth:3.5,

          animation: false,
          percent:getRatingPercent(compoundModal.location),
          center: new Text(
           compoundModal.location.toStringAsFixed(1),
            style:
            new TextStyle(color:  ColorClass.darkTextColor, fontSize: 12.0,fontWeight: FontWeight.w700),
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: ColorClass.circularBgColor,
          progressColor: Colors.green,
          footer: Padding(
            padding: const EdgeInsets.only(
                top: 8,right: 4),
            child: AutoSizeText(
                "Location",
                style: TextStyle(color: ColorClass.lightTextColor,fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,),
                textAlign: TextAlign.left
            ),
          ),
        ),
        CircularPercentIndicator(
          animation: false,
          radius:40,
          lineWidth:3.5,
          percent:getRatingPercent(compoundModal.value),
          center: new Text(
           compoundModal.value.toStringAsFixed(1),
            style:
            new TextStyle(   color:  ColorClass.darkTextColor,fontSize: 12.0,fontWeight: FontWeight.w700),
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: ColorClass.circularBgColor,
          progressColor:  Colors.orangeAccent,
          footer: Padding(
            padding: const EdgeInsets.only(
                top: 8,right: 4),
            child: AutoSizeText(
                "Value",
                style: TextStyle(color: ColorClass.lightTextColor,fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,),
                textAlign: TextAlign.left
            ),
          ),
        ),


        CircularPercentIndicator(
          radius:40,
          lineWidth:3.5,
          animation: false,
          percent:getRatingPercent(compoundModal.management),
          center: new Text(
          compoundModal.management.toStringAsFixed(1),
            style:
            new TextStyle(
                color:  ColorClass.darkTextColor,fontSize: 12.0,fontWeight: FontWeight.w700),
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: ColorClass.circularBgColor,
          progressColor: Colors.indigo,
          footer: Padding(
            padding: const EdgeInsets.only(
                top: 8,right: 4),
            child: AutoSizeText(
                "Management",
                style:TextStyle(color: ColorClass.lightTextColor,fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,),
                textAlign: TextAlign.left
            ),
          ),
        ),
      ],
    );
  }
}