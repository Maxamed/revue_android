import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/add_review/widgets/FormField.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';

import 'AddReviewBottomSheetSecond.dart';

class AddReviewBottomSheetFirst extends StatefulWidget{
  String compoundID="";
  String compoundName = "";

  AddReviewBottomSheetFirst({Key key,this.compoundID,this.compoundName}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddReviewBottomSheetState();
  }
}


class AddReviewBottomSheetState extends State<AddReviewBottomSheetFirst>{

  TextEditingController floorPlanController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bedroomController = TextEditingController();
  TextEditingController bathroomController = TextEditingController();

  ReviewModal reviewModal;

  bool rentValidate =  false;
  bool descriptionValidate = false;

  @override
  void initState() {
    super.initState();
    reviewModal  = new ReviewModal();
    reviewModal.compoundID = widget.compoundID;
    reviewModal.compoundName = widget.compoundName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [



          Container(
            width: MediaQuery.of(context).size.width,
            margin:EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(color: Colors.black12)
            ),
            child: Column(
              children: [
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
                              fontSize: 16.0
                          ),
                          textAlign: TextAlign.left
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: floorPlanController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 15),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
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
                      CustomTextField(label: 'Rent per month', withAsterisk: true),

                      TextField(
                        keyboardType: TextInputType.number,
                        controller: rentController,autofocus: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 15),
                            errorStyle: TextStyle(color: Colors.red),
                            errorText: rentValidate? 'Please enter something':null,
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
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
                          "Number of bedrooms",
                          style: const TextStyle(
                              color:  Colors.black,
                              fontWeight: FontWeight.w600,
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          ),
                          textAlign: TextAlign.left
                      ),

                      TextField(
                        keyboardType: TextInputType.number,
                        controller: bedroomController,autofocus: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 15),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
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
                          "Number of bathrooms",
                          style: const TextStyle(
                              color:  Colors.black,
                              fontWeight: FontWeight.w600,
                              fontStyle:  FontStyle.normal,
                              fontSize: 16.0
                          ),
                          textAlign: TextAlign.left
                      ),

                      TextField(
                        keyboardType: TextInputType.number,
                        controller: bathroomController,autofocus: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 15),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:  ColorClass.greyColor,),
                            ),
                            fillColor: Colors.white
                        ),),
                    ],
                  ),
                ),

                SizedBox(height: 20,),

              ],
            ),
          ),




        Container(
          width: MediaQuery.of(context).size.width,
          margin:EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.black12)
          ),

          child:  Padding(
            padding:  EdgeInsets.only(left: 20,right: 20,top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Name
               CustomTextField(label: 'Description',withAsterisk: true,),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          color: ColorClass.greyColor, width: 1)),
                  child: TextField(
                    keyboardType: TextInputType.multiline,autofocus: false,
                    maxLines: 10,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      errorText: descriptionValidate?'Please enter description':null,
                      hintText: "Add Description Here...",
                        hintStyle: TextStyle(color: ColorClass.greyColor,fontSize: 14),
                        contentPadding: EdgeInsets.all(15),
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,),
                        border: InputBorder.none,
                        fillColor: Colors.white
                    ),),
                ),
                SizedBox(height: 20,),


              ],
            ),
          ),
        ),


        // Align(alignment: Alignment.bottomRight,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //
        //       GestureDetector(
        //         behavior: HitTestBehavior.translucent,
        //         onTap: (){
        //           Navigator.pop(context);
        //           },
        //         child: Padding(
        //           padding: const EdgeInsets.all(10.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             children: [
        //               Icon(Icons.arrow_back_ios_outlined,color:Colors.black ,),
        //               Text(
        //                   "BACK",
        //                   style:   TextStyle(
        //                       color:  ColorClass.darkTextColor,
        //                       fontWeight: FontWeight.w600,
        //                       fontStyle:  FontStyle.normal,
        //                       fontSize: 18.0
        //                   ),
        //                   textAlign: TextAlign.left
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //
        //
        //
        //       GestureDetector(
        //         behavior: HitTestBehavior.translucent,
        //         onTap:rentController.text.isNotEmpty
        //             &&floorPlanController.text.isNotEmpty
        //             &&descriptionController.text.isNotEmpty? () {
        //
        //           reviewModal.price = rentController.text;
        //           reviewModal.floorplan = floorPlanController.text;
        //           reviewModal.review = descriptionController.text;
        //           print(reviewModal.review);
        //
        //           showModalBottomSheet(
        //               context: context,
        //               isScrollControlled: true,
        //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
        //                 topRight:Radius.circular(20), )),
        //               builder: (context) =>AddReviewBottomSheetSecond(globalKey: GlobalKeys.addReviewSecondKey,
        //                 reviewModal: reviewModal,));
        //
        //
        //         }:(){
        //           Fluttertoast.showToast(msg: "All Fields must be Filled");
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.all(10.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               Text(
        //                   "NEXT",
        //                   style:  TextStyle(
        //                       color:  ColorClass.darkTextColor,
        //                       fontWeight: FontWeight.w600,
        //                       fontStyle:  FontStyle.normal,
        //                       fontSize: 18.0
        //                   ),
        //                   textAlign: TextAlign.left
        //               ),
        //               Icon(Icons.arrow_forward_ios_outlined,color:Colors.black ,)
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),)

      ],),
    );
  }



bool validate()
{
  return rentController.text.isNotEmpty
              &&descriptionController.text.isNotEmpty;
}

bool validateRent(){
    if(rentController.text.isEmpty){
      setState(() {
        rentValidate = true;
      });
      return true;
    }else{
      setState(() {
        rentValidate = false;
      });
      return false;
    }
}

  bool validateDescription(){
    if(descriptionController.text.isEmpty){
      setState(() {
        descriptionValidate= true;
      });
      return true;
    }else{
      setState(() {
        descriptionValidate = false;
      });
      return false;
    }
  }


}

