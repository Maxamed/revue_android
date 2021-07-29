import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:revue_mobile/Login.dart';
import 'package:revue_mobile/Modal/CompoundModal.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/add_review/Add_Review.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';
import 'package:revue_mobile/constant/StringConstant.dart';
import 'package:revue_mobile/reviews/review_card.dart';

import 'RevueDetail.dart';

class ReviewList extends StatefulWidget{
  List reviewList = [];
CompoundModal compoundModal;
  ReviewList({Key key,this.reviewList,this.compoundModal}):super(key: key);

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
      child: widget.reviewList.isEmpty?
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("No Review Added",style: TextStyle(color: ColorClass.darkTextColor,fontWeight:
            FontWeight.w400,fontSize: 16),),
          ):

      Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: exists? widget.reviewList.length:
            widget.reviewList.length<2?
            1:2,
            itemBuilder: (context, index) {
              double rating  = (widget.reviewList[index] as ReviewModal).rating;
              return ReviewCard((widget.reviewList[index] as ReviewModal), rating, widget.reviewList);
            },
          ),
          exists?Container():
          widget.reviewList.length<3?
          Padding(
            padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 20),
            child: Text("Please add Review to view more Reviews",
              style: TextStyle(color: ColorClass.redColor,fontWeight: FontWeight.w500,fontSize: 16),),
          ):
          Padding(
            padding: const EdgeInsets.only(top: 10,right: 10,left: 10,bottom: 20),
            child: Text("Please add Review to view more Reviews",
              style: TextStyle(color: ColorClass.redColor,fontWeight: FontWeight.w500,fontSize: 16),),
          )

        ],
      ),
    );
  }

  void openAddReview()
  {
    CupertinoScaffold.
    showCupertinoModalBottomSheet(
        context: context,backgroundColor: Colors.white,
        barrierColor: Colors.black.withAlpha(10),
        builder: (context)=>CupertinoScaffold(transitionBackgroundColor: Colors.white,
            body: AddReview(key: GlobalKeys.addReviewKey,compoundID: widget.compoundModal.id,compoundName: widget.compoundModal.compoundname)));

  }


  bool exists;

  @override
  void initState() {
    super.initState();
    checkReviews();
  }


  checkReviews()async{
    exists = await Webservice.checkReview(widget.compoundModal.id);
    setState(() {

    });
  }
}