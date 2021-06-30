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
            padding: const EdgeInsets.all(8.0),
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
                                fontSize: 20.0
                            ),
                            textAlign: TextAlign.left
                        ),
                        SizedBox(height: 5,),
                        Row(children: [
                          Text("Posted On   ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,
                              fontSize: 14),),
                          Text(StringConstant.getReviewPostedDate( (widget.reviewList[index] as ReviewModal).reviewDate),style: TextStyle(color: ColorClass.lightTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14))
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
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: ColorClass.circularBgColor,
                        progressColor: ColorClass.redColor,
                        footer: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                              "Overall Rating",
                              style:  TextStyle(
                                  color:ColorClass.lightTextColor  ,
                                  fontWeight: FontWeight.w700,

                                  fontStyle:  FontStyle.normal,
                                  fontSize: 12.0
                              ),
                              textAlign: TextAlign.left
                          ),
                        ),
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
                        fontWeight: FontWeight.w600,

                        fontStyle:  FontStyle.normal,
                        fontSize: 15.0
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
                          fontWeight: FontWeight.w500,
                          fontStyle:  FontStyle.normal,
                          fontSize: 13.0),
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
                              color:  ColorClass.lightTextColor,
                              fontStyle:  FontStyle.normal,
                              fontSize: 15.0,
                            fontWeight: FontWeight.w500,),
                          textAlign: TextAlign.left),
                      // 45000 INR
                      Text((widget.reviewList[index] as ReviewModal).price +" QAR",
                          style:  TextStyle(
                              color:  ColorClass.lightTextColor,
                              fontStyle:  FontStyle.normal,
                              fontSize: 15.0,
                            fontWeight: FontWeight.w500,),
                          textAlign: TextAlign.left),
                      // View more
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          CupertinoScaffold.
                          showCupertinoModalBottomSheet(context: context,backgroundColor: Colors.white,
                              barrierColor: Colors.white,
                              builder: (context)=>RevueDetail(widget.reviewList[index] as ReviewModal,widget.reviewList.length));
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext c) {
                          //       return AlertDialog(
                          //         backgroundColor: Colors.white,
                          //         insetPadding: EdgeInsets.all(20),
                          //         contentPadding: EdgeInsets.zero,
                          //         clipBehavior:
                          //         Clip.antiAliasWithSaveLayer,
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius:
                          //             BorderRadius.circular(
                          //                 20)),
                          //         content: RevueDetail(widget.reviewList[index] as ReviewModal,widget.reviewList.length),
                          //       );
                          //     });
                        },
                        child: Text("View more".toUpperCase(),
                            style:  TextStyle(fontSize: 15,
                                color: ColorClass.blueColor,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: ColorClass.greyColor,
                  thickness: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}