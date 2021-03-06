
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class AddReviewBottomSheetThird extends  StatefulWidget{
  AddReviewBottomSheetThird({Key key}):super(key: key);

  // ReviewModal reviewModal;

  // AddReviewBottomSheetThird(this.reviewModal);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddReviewBottomSheetThirdState();
  }
}
class AddReviewBottomSheetThirdState extends State<AddReviewBottomSheetThird>{
  double facilitiesRating = 0;
  double valueRating = 0;
  double managementRating = 0;
  double designRating = 0;
  double locationRating = 0;
  bool checkBox = false;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Future<void> androidDatePicker(BuildContext context,TextEditingController controller)async{
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2150),
    ).then((selectedDate) {
      if (selectedDate != null) {
        controller.text =
            DateFormat('dd/MM/yyyy').format(selectedDate);
      }
    });



  }


  Future<void> iosDatePicker(BuildContext context,TextEditingController controller)async{
    DatePicker.showDatePicker(context,
      theme: DatePickerTheme(
        containerHeight: 210.0,
      ),
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime(2150,1,12), onConfirm: (date) {
        print('confirm $date');
        startDateController.text = DateFormat('dd/MM/yyyy').format(date);
        setState(() {});
      }, currentTime: DateTime.now(), locale: LocaleType.en,);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

        Container(
          margin:EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.black12)
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Facilities",
                        style: const TextStyle(
                            color:  const Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        ),
                        textAlign: TextAlign.left
                    ),

                    GFRating(
                      size: 25,
                      value: facilitiesRating,allowHalfRating: true,borderColor: ColorClass.greyColor,
                      color: ColorClass.blueColor,
                      onChanged: (value) {
                        setState(() {
                          facilitiesRating = value;
                          // widget.reviewModal.facilities = facilitiesRating;
                        });

                      },
                    )

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Design",
                        style: const TextStyle(
                            color:  const Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        ),
                        textAlign: TextAlign.left
                    ),

                    GFRating(
                      size: 25,
                      value: designRating,allowHalfRating: true,borderColor: ColorClass.greyColor,
                      color: ColorClass.blueColor,
                      onChanged: (value) {
                        setState(() {
                          designRating = value;
                          // widget.reviewModal.design = value;
                        });

                      },
                    )

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Location",
                        style: const TextStyle(
                            color:  const Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        ),
                        textAlign: TextAlign.left
                    ),

                    GFRating(
                      size: 25,
                      value: locationRating,allowHalfRating: true,borderColor: ColorClass.greyColor,
                      color:ColorClass.blueColor,
                      onChanged: (value) {
                        setState(() {
                          locationRating = value;
                          // widget.reviewModal.location = value;
                        });
                      },
                    )

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Value",
                        style: const TextStyle(
                            color:  const Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        ),
                        textAlign: TextAlign.left
                    ),

                    GFRating(
                      size: 25,
                      value: valueRating,allowHalfRating: true,borderColor: ColorClass.greyColor,
                      color: ColorClass.blueColor,
                      onChanged: (value) {
                        setState(() {
                          valueRating = value;
                          // widget.reviewModal.value = value;
                        });
                      },
                    )

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Management",
                        style: const TextStyle(
                            color:  const Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 16.0
                        ),
                        textAlign: TextAlign.left
                    ),

                    GFRating(
                      size: 25,
                      value: managementRating,allowHalfRating: true,borderColor: ColorClass.greyColor,
                      color: ColorClass.blueColor,
                      onChanged: (value) {
                        setState(() {
                          managementRating = value;
                          // widget.reviewModal.management = value;
                        });
                      },
                    )

                  ],
                ),
              ),
              SizedBox(height: 20,)
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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Start Date",
                            style: TextStyle(
                                color:Colors.black,
                                fontWeight: FontWeight.w600,

                                fontStyle:  FontStyle.normal,
                                fontSize: 16.0
                            ),
                            textAlign: TextAlign.left
                        ),

                        IconButton(icon: Icon(CupertinoIcons.calendar,size: 30,color: ColorClass.blueColor),
                          onPressed: (){
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          if(Platform.isAndroid){
                            androidDatePicker(context, startDateController);

                          }else{
                            iosDatePicker(context, startDateController);

                          }

                          },)
                      ],
                    ),
                    TextField(
                      controller: startDateController,
                      readOnly: true,autofocus: false,
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
              checkBox==false?
              Container(
                margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Name
                    Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "End Date",
                            style: TextStyle(
                                color:Colors.black,
                                fontWeight: FontWeight.w600,
                                fontStyle:  FontStyle.normal,
                                fontSize: 16.0
                            ),
                            textAlign: TextAlign.left
                        ),

                        IconButton(icon: Icon(CupertinoIcons.calendar,size: 30,color: ColorClass.blueColor,),
                          onPressed: (){
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }


                             if(Platform.isAndroid){
                              androidDatePicker(context, endDateController);
                            }else{
                              iosDatePicker(context, endDateController);
                            }
                            },)
                      ],
                    ),
                    TextField(
                      controller: endDateController,
                      readOnly: true,enabled: false,
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
              ):Container(),
              SizedBox(height: 20,)
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
              padding: const EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Currently staying",
                      style: const TextStyle(
                          color:  const Color(0xff000000),
                          fontWeight: FontWeight.w600,
                          fontStyle:  FontStyle.normal,
                          fontSize: 16.0
                      ),
                      textAlign: TextAlign.left
                  ),
                  GFCheckbox(
                    size: 20,
                    activeBorderColor: Colors.black,
                    activeBgColor: ColorClass.blueColor,
                    type: GFCheckboxType.square,inactiveBorderColor: ColorClass.greyColor,
                    value:checkBox,
                    onChanged: (value){

                      setState(() {
                        checkBox = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),


      ],),
    );
  }


  bool validate(){
    return facilitiesRating!=0
                    &&designRating!=0
                    &&locationRating!=0
                    &&valueRating!= 0
                    &&managementRating!=0
                    &&startDateController.text.isNotEmpty;
  }


  void addToReview(ReviewModal reviewModal){
    // double rating = ;
    //               print(rating);
                  reviewModal.facilities = facilitiesRating;
                  reviewModal.value = valueRating;
                  reviewModal.location = locationRating;
                  reviewModal.management = managementRating;
                  reviewModal.design = designRating;
          reviewModal.rating =((facilitiesRating+designRating+locationRating+valueRating+managementRating)/5);
          reviewModal.reviewDate =DateTime.now().millisecondsSinceEpoch;

  }

}





