
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class AddReviewBottomSheetThird extends  StatefulWidget{

  ReviewModal reviewModal;

  AddReviewBottomSheetThird(this.reviewModal);

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

  // showStartDatePickerWidget(){
  //   return showCupertinoModalPopup(
  //       context: context,
  //       builder:  (BuildContext builder){
  //         return Container(
  //             height: MediaQuery.of(context).copyWith().size.height / 3,
  //             child: CupertinoDatePicker(
  //               backgroundColor: Colors.black,
  //               initialDateTime: DateTime.now().subtract(Duration(hours: 1)),
  //               onDateTimeChanged: (DateTime newdate) {
  //                 print(newdate);
  //                 var formatter = new DateFormat('dd/MM/yyyy');
  //                 // String formattedTime = DateFormat('kk:mm:a').format(newdate);
  //                 String formattedDate = formatter.format(newdate);
  //                 // print(formattedTime);
  //                 print(formattedDate);
  //                 setState(() {
  //                   startDateController.text=formattedDate;
  //                 });
  //               },
  //
  //               use24hFormat: false,
  //               maximumDate: new DateTime(2050, 12, 31),
  //               minimumYear: 2010,
  //               maximumYear: 2040,
  //               minuteInterval: 1,
  //               mode: CupertinoDatePickerMode.date,
  //             )
  //         );
  //       }
  //   );
  // }
  //
  // showEndDatePickerWidget(){
  //   return showCupertinoModalPopup(
  //       context: context,
  //       builder:  (BuildContext builder){
  //         return Container(
  //             height: MediaQuery.of(context).copyWith().size.height / 3,
  //             child: CupertinoDatePicker(
  //               backgroundColor: Colors.black,
  //               initialDateTime: DateTime.now().subtract(Duration(hours: 1)),
  //               onDateTimeChanged: (DateTime newdate) {
  //                 print(newdate);
  //                 var formatter = new DateFormat('MM/dd/yyyy');
  //                 String formattedTime = DateFormat('kk:mm:a').format(newdate);
  //                 String formattedDate = formatter.format(newdate);
  //                 print(formattedTime);
  //                 print(formattedDate);
  //                 setState(() {
  //                   endDateController.text=formattedDate;
  //                 });
  //               },
  //
  //               use24hFormat: false,
  //               maximumDate: new DateTime(2050, 12, 31),
  //               minimumYear: 2010,
  //               maximumYear: 2040,
  //               minuteInterval: 1,
  //               mode: CupertinoDatePickerMode.date,
  //             )
  //         );
  //       }
  //   );
  // }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView(children: [

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
                      fontSize: 18.0
                  ),
                  textAlign: TextAlign.left
              ),

              GFRating(
                size: 30,
                value: facilitiesRating,allowHalfRating: true,borderColor: ColorClass.lightTextColor,
                color: ColorClass.blueColor,
                onChanged: (value) {
                  setState(() {
                    facilitiesRating = value;
                    widget.reviewModal.facilities = facilitiesRating;
                    widget.reviewModal.facilities = value;
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
                      fontSize: 18.0
                  ),
                  textAlign: TextAlign.left
              ),

              GFRating(
                size: 30,
                value: designRating,allowHalfRating: true,borderColor: ColorClass.lightTextColor,
                color: ColorClass.blueColor,
                onChanged: (value) {
                  setState(() {
                    designRating = value;
                    widget.reviewModal.design = value;
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
                      fontSize: 18.0
                  ),
                  textAlign: TextAlign.left
              ),

              GFRating(
                size: 30,
                value: locationRating,allowHalfRating: true,borderColor: ColorClass.lightTextColor,
                color:ColorClass.blueColor,
                onChanged: (value) {
                  setState(() {
                    locationRating = value;
                    widget.reviewModal.location = value;
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
                      fontSize: 18.0
                  ),
                  textAlign: TextAlign.left
              ),

              GFRating(
                size: 30,
                value: valueRating,allowHalfRating: true,borderColor: ColorClass.lightTextColor,
                color: ColorClass.blueColor,
                onChanged: (value) {
                  setState(() {
                    valueRating = value;
                    widget.reviewModal.value = value;
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
                      fontSize: 18.0
                  ),
                  textAlign: TextAlign.left
              ),

              GFRating(
                size: 30,
                value: managementRating,allowHalfRating: true,borderColor: ColorClass.lightTextColor,
                color: ColorClass.blueColor,
                onChanged: (value) {
                  setState(() {
                    managementRating = value;
                    widget.reviewModal.management = value;
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
                  "Currently staying the same",
                  style: const TextStyle(
                      color:  const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                      fontStyle:  FontStyle.normal,
                      fontSize: 18.0
                  ),
                  textAlign: TextAlign.left
              ),
              GFCheckbox(
                size: 20,
                activeBorderColor: Colors.black,
                activeBgColor: ColorClass.blueColor,
                type: GFCheckboxType.square,inactiveBorderColor: ColorClass.lightTextColor,
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
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.left
                  ),

                  IconButton(icon: Icon(CupertinoIcons.calendar,size: 30,),
                    onPressed: (){
                    if(Platform.isAndroid){
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2150),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          startDateController.text =
                              DateFormat('dd/MM/yyyy').format(selectedDate);
                        }
                      });
                    }else{


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

                    },)
                ],
              ),
              TextField(
                controller: startDateController,
                readOnly: true,
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
                          fontSize: 18.0
                      ),
                      textAlign: TextAlign.left
                  ),

                  IconButton(icon: Icon(CupertinoIcons.calendar,size: 30,),
                    onPressed: (){
                      if(Platform.isAndroid){
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2150),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            endDateController.text =
                                DateFormat('dd/MM/yyyy').format(selectedDate);
                          }
                        });
                      }else{


                        DatePicker.showDatePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime(2150,1,12), onConfirm: (date) {
                            print('confirm $date');
                            endDateController.text = DateFormat('dd/MM/yyyy').format(date);
                            setState(() {});
                          }, currentTime: DateTime.now(), locale: LocaleType.en,);

                      }


                    },)
                ],
              ),
              TextField(
                controller: endDateController,
                readOnly: true,
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


        Align(alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 30,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_back_ios_outlined,color:Colors.black ,),
                        Text(
                            "BACK",
                            style: const TextStyle(
                                color:  const Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontStyle:  FontStyle.normal,
                                fontSize: 18.0
                            ),
                            textAlign: TextAlign.left
                        ),
                      ],
                    ),
                  ),
                ),


                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap:facilitiesRating!=0
                      &&designRating!=0
                      &&locationRating!=0
                      &&valueRating!= 0
                      &&managementRating!=0
                      &&startDateController.text.isNotEmpty
                      &&endDateController.text.isNotEmpty? ()
                  {
                    double rating = (facilitiesRating+designRating+locationRating+valueRating+managementRating)/5;
                    print(rating);
                    widget.reviewModal.rating = rating;

                    widget.reviewModal.reviewDate =DateTime.now().millisecondsSinceEpoch;

                    Webservice.addReviewRequest(context, widget.reviewModal).then((value) =>
                        this.setState(() {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    }));
                  }:null,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            "DONE",
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
                ),
              ],
            ),
          ),)

      ],),
    );
  }



}





