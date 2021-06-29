import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

import 'AddReviewBottomSheetSecond.dart';

class AddReviewBottomSheetFirst extends StatefulWidget{
  String compoundID="";
  String compoundName = "";

  AddReviewBottomSheetFirst(this.compoundID,this.compoundName);

  @override
  State<StatefulWidget> createState() {
    return AddReviewBottomSheetState();
  }
}


class AddReviewBottomSheetState extends State<AddReviewBottomSheetFirst>{

  TextEditingController floorPlanController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ReviewModal reviewModal;

  @override
  void initState() {
    super.initState();
    reviewModal  = new ReviewModal();
    reviewModal.compoundID = widget.compoundID;
    reviewModal.compoundName = widget.compoundName;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 600,
        child: ListView(shrinkWrap: true,children: [

          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 30),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Name
                Text(
                    "Floor Plan (sqft)",
                    style:  TextStyle(
                        color:Colors.black,
                        fontWeight: FontWeight.w600,
                        fontStyle:  FontStyle.normal,
                        fontSize: 18.0
                    ),
                    textAlign: TextAlign.left
                ),
                TextField(textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: floorPlanController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color:  ColorClass.greyColor,),
                      ),
                      fillColor: Colors.white
                  ),),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 30),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Name
                Text(
                    "Rent",
                    style: const TextStyle(
                        color:  Colors.black,
                        fontWeight: FontWeight.w600,
                        fontStyle:  FontStyle.normal,
                        fontSize: 18.0
                    ),
                    textAlign: TextAlign.left
                ),
                TextField(textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  controller: rentController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color:  ColorClass.greyColor,),
                      ),
                      fillColor: Colors.white
                  ),),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20,right: 20,top: 30),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Name
                Text(
                    "Description",
                    style: const TextStyle(
                        color:  Colors.black,
                        fontWeight: FontWeight.w600,

                        fontStyle:  FontStyle.normal,
                        fontSize: 18.0
                    ),
                    textAlign: TextAlign.left
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          color: ColorClass.borderColor, width: 1)),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,),
                        border: InputBorder.none,
                        fillColor: Colors.white
                    ),),
                ),
              ],
            ),
          ),

          SizedBox(height: 200,),

          Align(alignment: Alignment.bottomRight,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap:rentController.text.isNotEmpty
                  &&floorPlanController.text.isNotEmpty
                  &&descriptionController.text.isNotEmpty? () {

                reviewModal.price = rentController.text;
                reviewModal.floorplan = floorPlanController.text;
                reviewModal.review = descriptionController.text;
                print(reviewModal.review);

                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                      topRight:Radius.circular(20), )),
                    builder: (context) =>AddReviewBottomSheetSecond(globalKey: globalKey,
                      reviewModal: reviewModal,));


              }:null,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        "NEXT",
                        style: const TextStyle(
                            color:  const Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 18.0
                        ),
                        textAlign: TextAlign.left
                    ),
                    Icon(Icons.arrow_forward_ios_outlined,color:Colors.black ,)
                  ],
                ),
              ),
            ),)

        ],),
      ),
    );
  }
}