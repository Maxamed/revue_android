import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetFirst.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetSecond.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetThird.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';

class AddReview extends StatefulWidget{
  String compoundID="";
  String compoundName = "";


  AddReview({Key key,this.compoundID, this.compoundName}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return AddReviewState();
  }
}

class AddReviewState extends State<AddReview>{
  ReviewModal reviewModal;

  bool load=false;

  @override
  void initState() {
    super.initState();
    reviewModal = new ReviewModal();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text("Add Review",style: TextStyle(color: Colors.black87,fontSize: 14),),
          backgroundColor: Colors.grey.shade50,
          // trailing: TextButton(child: Text("Close",style: TextStyle(fontSize: 14,color: ColorClass.blueColor,fontWeight: FontWeight.w600),),onPressed: (){
          //   Navigator.pop(context);
          // },),
          // leading: GestureDetector(
          //   behavior: HitTestBehavior.translucent,
          //   child: Icon(CupertinoIcons.back,size: 25,),onTap: (){},)
      ),
      child: Material(
        child: SingleChildScrollView(
          child: Column(children: [
          AddReviewBottomSheetFirst(key: GlobalKeys.addReviewFirstKey,compoundID: widget.compoundID,compoundName: widget.compoundName,),
          AddReviewBottomSheetSecond(globalKey: GlobalKeys.addReviewSecondKey,),
          AddReviewBottomSheetThird(key: GlobalKeys.addReviewThirdKey,),

          SizedBox(height: 40,),
          ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            primary: ColorClass.blueColor,  padding: EdgeInsets.only(left:100,right: 100,top:10,bottom: 10),
          ),
          onPressed: () async{
            if(GlobalKeys.addReviewSecondKey.currentState.pickedImages.isEmpty)
            {
              Fluttertoast.showToast(msg: "Please select at least a Image");
            }
          if(GlobalKeys.addReviewFirstKey.currentState.validate()
              &&GlobalKeys.addReviewSecondKey.currentState.validate()
          &&GlobalKeys.addReviewThirdKey.currentState.validate()){

            reviewModal.price = GlobalKeys.addReviewFirstKey.currentState.rentController.text;
            reviewModal.floorplan = GlobalKeys.addReviewFirstKey.currentState.floorPlanController.text;
            reviewModal.review = GlobalKeys.addReviewFirstKey.currentState.descriptionController.text;
            reviewModal.bedRooms = int.parse(GlobalKeys.addReviewFirstKey.currentState.bedroomController.text);
            reviewModal.bathRooms = int.parse(GlobalKeys.addReviewFirstKey.currentState.bathroomController.text);
           await GlobalKeys.addReviewSecondKey.currentState.addToReview(reviewModal);
            GlobalKeys.addReviewThirdKey.currentState.addToReview(reviewModal);
            reviewModal.compoundID = widget.compoundID;
            reviewModal.compoundName = widget.compoundName;


            Webservice.addReviewRequest(context, reviewModal);
           // Navigator.pop(context);
          }
          else
          {
            Fluttertoast.showToast(msg: "All Fields Are Required");
          }

          },
          child: load?
          CollectionScaleTransition(
            // end: Offset.fromDirection(-1.5,0.5),
            children: [
              Padding(
                padding: const EdgeInsets.only(left:4,right: 4),
                child: Text("⚪️",style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 4
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:4,right: 4),
                child: Text("⚪️",style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 4
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:4,right: 4),
                child: Text("⚪️",style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 4
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:4,right: 4),
                child: Text("⚪️",style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 4
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:4,right: 4),
                child: Text("⚪️",style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 4
                ),),
              ),

            ],):

          Text("Done",style: TextStyle(fontSize: 16,color: Colors.white,),),

          ),

            SizedBox(height: 20,),

      ],),
        ),
      ),
    );
  }
}