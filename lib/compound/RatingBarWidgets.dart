import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class RatingBarWidgets extends StatefulWidget {
  List reviweList =[];

  RatingBarWidgets(this.reviweList);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RatingBarWidgetState();
  }

}

class RatingBarWidgetState extends State<RatingBarWidgets>{

  int excellent =0;
  int veryGood=0 ;
  int average = 0;
  int veryPoor =0;
  int poor = 0;

  List list =[];
  @override
  void initState() {
    super.initState();
    list = widget.reviweList;
    getRatingCount();


  }
  
  getRatingCount(){
    print("list length"+list.length.toString());
    for(int i=0;i<list.length;i++){
      print((list[i] as ReviewModal).rating);
    }
  }

 double getPercentage(int count){
    print(count);
    double value = (count/list.length)*100;
    print(value);
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Excellent".toUpperCase(),
                style: TextStyle(color: ColorClass.lightTextColor,fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,),
              ),
              LinearPercentIndicator(
                trailing: Text(getPercentage(excellent).toStringAsFixed(1),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    textAlign: TextAlign.left),
                progressColor: Color(0xff0c5324),
                linearStrokeCap: LinearStrokeCap.butt,
                fillColor: Colors.white,
                backgroundColor: Color(0xcce5e5e5),
                lineHeight: 15,
                width: 170,
                percent: 0.7,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Very Good".toUpperCase(),
                style: TextStyle(color: ColorClass.lightTextColor,fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,),
              ),
              LinearPercentIndicator(
                trailing: Text(getPercentage(veryGood).toStringAsFixed(1),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    textAlign: TextAlign.left),
                progressColor: Color(0xff0c5324),
                linearStrokeCap: LinearStrokeCap.butt,
                fillColor: Colors.white,
                backgroundColor: Color(0xcce5e5e5),
                lineHeight: 15,
                width: 170,
                percent: 0.8,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Average".toUpperCase(),
                style:TextStyle(color: ColorClass.lightTextColor,fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,),
              ),
              LinearPercentIndicator(
                trailing: Text(getPercentage(average).toStringAsFixed(1),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    textAlign: TextAlign.left),
                progressColor: Color(0xff0c5324),
                linearStrokeCap: LinearStrokeCap.butt,
                fillColor: Colors.white,
                backgroundColor: Color(0xcce5e5e5),
                lineHeight: 15,
                width: 170,
                percent: 0.2,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Poor".toUpperCase(),
                style: TextStyle(color: ColorClass.lightTextColor,fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,),
              ),
              LinearPercentIndicator(
                trailing: Text(getPercentage(poor).toString(),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    textAlign: TextAlign.left),
                progressColor: Color(0xff0c5324),
                linearStrokeCap: LinearStrokeCap.butt,
                fillColor: Colors.white,
                backgroundColor: Color(0xcce5e5e5),
                lineHeight: 15,
                width: 170,
                percent: 0.1,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Very Poor".toUpperCase(),
                style: TextStyle(color: ColorClass.lightTextColor,fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,),
              ),
              LinearPercentIndicator(
                trailing: Text(getPercentage(veryPoor).toString(),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        fontSize: 12.0),
                    textAlign: TextAlign.left),
                progressColor: Color(0xff0c5324),
                linearStrokeCap: LinearStrokeCap.butt,
                fillColor: Colors.white,
                backgroundColor: Color(0xcce5e5e5),
                lineHeight: 15,
                width: 170,
                percent: 0.0,
              ),
            ],
          ),
        ),
      ],
    );
  }


}
