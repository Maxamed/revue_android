import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:revue_mobile/Login.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/StringConstant.dart';

import 'RevueDetail.dart';

class ReviewList extends StatefulWidget{
  List reviewList = [];

  ReviewList(this.reviewList);

  @override
  State<StatefulWidget> createState() {
    return ReviewListState();
  }
}

class ReviewListState extends State<ReviewList>{
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child:  ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.reviewList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left:8.0,right:8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Flexible(flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            (widget.reviewList[index] as ReviewModal).reviewerName.toUpperCase(),
                            style: TextStyle(
                                color:ColorClass.redColor,
                                fontWeight: FontWeight.w600,
                                fontStyle:  FontStyle.normal,
                                fontSize: 17.0
                            ),
                            textAlign: TextAlign.left
                        ),
                        SizedBox(height: 10,),
                        Row(children: [
                          Text("Posted On   ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,
                              fontSize: 14),),
                          Text(StringConstant.getReviewPostedDate( (widget.reviewList[index] as ReviewModal).reviewDate),style: TextStyle(color: ColorClass.lightTextColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12))
                        ],),

                      ],
                    ),),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:   CircularPercentIndicator(
                        radius: 40.0,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 4.0,
                        percent: StringConstant.getpercentage((widget.reviewList[index] as ReviewModal).rating),
                        center: new Text(
                          (widget.reviewList[index] as ReviewModal).rating.toString(),
                          style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: ColorClass.circularBgColor,
                        progressColor: ColorClass.redColor,
                        // footer: Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //       "Overall Rating",
                        //       style:  TextStyle(
                        //           color:Colors.black87 ,
                        //           fontWeight: FontWeight.w500,
                        //
                        //           fontStyle:  FontStyle.normal,
                        //           fontSize: 12.0
                        //       ),
                        //       textAlign: TextAlign.left
                        //   ),
                        // ),
                      ),

                    ),
                  )
                ],),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Description",
                    style:  TextStyle(
                        color: ColorClass.darkTextColor,
                        fontWeight: FontWeight.w500,

                        fontStyle:  FontStyle.normal,
                        fontSize: 14.0
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8,bottom: 5,top: 5),
                  child: Text(
                      (widget.reviewList[index] as ReviewModal).review,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style:  TextStyle(
                          color:  ColorClass.lightTextColor,
                          fontWeight: FontWeight.w400,
                          fontStyle:  FontStyle.normal,
                          fontSize: 12.0),
                      textAlign: TextAlign.left),
                ),

                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      // 1350 sqft
                      Text((widget.reviewList[index] as ReviewModal).floorplan +" SQFT",
                          style:  TextStyle(
                              color:  Colors.black87,
                              fontStyle:  FontStyle.normal,
                              fontSize: 14.0,
                            fontWeight: FontWeight.w400,),
                          textAlign: TextAlign.left),
                      // 45000 INR
                      Text((widget.reviewList[index] as ReviewModal).price +" QAR",
                          style:  TextStyle(
                              color:  Colors.black87,
                              fontStyle:  FontStyle.normal,
                              fontSize: 14.0,
                            fontWeight: FontWeight.w400,),
                          textAlign: TextAlign.left),
                      // View more
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          CupertinoScaffold.
                          showCupertinoModalBottomSheet(
                              context: context,backgroundColor: Colors.white,
                              barrierColor: Colors.black.withAlpha(10),
                              builder: (context)=>CupertinoScaffold(transitionBackgroundColor: Colors.white,
                                  body: RevueDetail(widget.reviewList[index] as ReviewModal,widget.reviewList.length)));

                        },
                        child: Text("View more".toUpperCase(),
                            style:  TextStyle(fontSize: 12,
                                color: ColorClass.blueColor,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: ColorClass.greyColor,
                  thickness: 0.5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}