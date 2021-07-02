import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:revue_mobile/Modal/MyReviewsModal.dart';
import 'package:revue_mobile/Service/ServerDetails.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/StringConstant.dart';
import 'package:revue_mobile/reviews/widgets/bathroom_widget.dart';
import 'package:revue_mobile/reviews/widgets/bedroom_widget.dart';
import 'package:revue_mobile/reviews/widgets/floorplan_widget.dart';
import 'package:revue_mobile/reviews/widgets/price_widget.dart';
import 'package:revue_mobile/reviews/widgets/rating_widget.dart';
import 'package:revue_mobile/reviews/widgets/reviewdate_widget.dart';

class MyReviewDetails extends StatefulWidget{
  final MyReviewsModal myReviewsModal;


  MyReviewDetails(this.myReviewsModal);

  @override
  State<StatefulWidget> createState() {
    return MyReviewDetailState();
  }
}

class MyReviewDetailState extends State<MyReviewDetails>{

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      child: Scaffold(
        // bottomNavigationBar: new Stack(
        //   children: <Widget>[
        //     Container(
        //       width: MediaQuery.of(context).size.width,
        //       height: 80,
        //       child: Padding(
        //         padding: const EdgeInsets.all(10),
        //         child: SizedBox(
        //           width: 140,
        //           child: Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                   shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(5),
        //                 ),   primary: ColorClass.redColor,
        //                 padding: EdgeInsets.all(10)
        //               ),
        //
        //               onPressed: () {},
        //
        //               child: Text(
        //                 "Edit Review",
        //                 style: TextStyle(fontSize: 16,color: Colors.white),
        //               ),
        //
        //             ),
        //           ),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        
        
        body: CustomScrollView(

          slivers: [
          CupertinoSliverNavigationBar(backgroundColor: Colors.white,
            automaticallyImplyLeading: false,leading:
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.chevron_left,
                  color: Colors.black,
                )),
          largeTitle:
          Text(widget.myReviewsModal.compoundName,
              style:  TextStyle(
              color:  ColorClass.redColor,
              fontWeight: FontWeight.w700,
              fontStyle:  FontStyle.normal,
              fontSize: 18.0
          ),
              textAlign: TextAlign.left
          ),
        ),
           SliverPadding(padding: EdgeInsets.all(8) ,
             sliver: SliverList(
                 delegate: SliverChildListDelegate(
                     [


               Container(
                 width: MediaQuery.of(context).size.width,
                 height: 200,
                 child: Swiper(
                   itemBuilder: (BuildContext context, int index) {
                     return new Image.network(
                       ServerDetails.get_images+widget.myReviewsModal.images[index],
                       fit: BoxFit.fill,
                     );
                   },
                   autoplay: false,
                   itemCount:widget.myReviewsModal.images.length,
                   pagination: new SwiperPagination(),
                 ),
               ),

               SizedBox(height: 10,),


               Row(mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Flexible(
                     fit: FlexFit.tight,flex: 1,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         PriceWidget(widget.myReviewsModal.price),
                         BedRoomWidget(widget.myReviewsModal.bathRooms.toString()),
                         // RatingWidget(2,widget.myReviewsModal.rating)
                       ],),
                   ),
                   Flexible(
                     fit: FlexFit.tight,flex: 1,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         FloorPlanWidget(widget.myReviewsModal.floorplan),
                         BathRoomWidget(widget.myReviewsModal.bathRooms.toString()),
                         // ReviewDateWidget(widget.myReviewsModal.reviewDate)

                       ],),
                   )
                 ],),

               SizedBox(height: 20,),

               Text("Ratings",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,
                 fontSize: 16,
                 fontStyle:  FontStyle.normal,
               ),),

               Container(
                   height: 100,alignment: Alignment.center,
                   child: Row(mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CircularPercentIndicator(
                         radius: 40.0,
                         animation: true,
                         animationDuration: 1200,
                         lineWidth: 3.5,
                         percent: StringConstant.getpercentage(widget.myReviewsModal.facilities),
                         center: new Text(
                           widget.myReviewsModal.facilities.toString(),
                           style:
                           new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                         ),
                         circularStrokeCap: CircularStrokeCap.butt,
                         backgroundColor: ColorClass.circularBgColor,
                         progressColor: Colors.orange,
                         footer: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                               "Facilites",
                               style:  TextStyle(
                                   color:  ColorClass.lightTextColor,
                                   fontWeight: FontWeight.w700,
                                   fontStyle:  FontStyle.normal,
                                   fontSize: 12.0
                               ),
                               textAlign: TextAlign.left
                           ),
                         ),
                       ),
                       CircularPercentIndicator(
                         radius: 40.0,
                         animation: true,
                         animationDuration: 1200,
                         lineWidth: 3.5,
                         percent: StringConstant.getpercentage(widget.myReviewsModal.design),
                         center: new Text(
                           widget.myReviewsModal.design.toString(),
                           style:
                           new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                         ),
                         circularStrokeCap: CircularStrokeCap.butt,
                         backgroundColor: ColorClass.circularBgColor,
                         progressColor: Colors.blue,
                         footer:  Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                               "Design",
                               style:  TextStyle(
                                   color:  ColorClass.lightTextColor,
                                   fontWeight: FontWeight.w700,
                                   fontStyle:  FontStyle.normal,
                                   fontSize: 12.0
                               ),
                               textAlign: TextAlign.left
                           ),
                         ),
                       ),
                       CircularPercentIndicator(
                         radius: 40.0,
                         animation: true,
                         animationDuration: 1200,
                         lineWidth: 3.5,
                         percent: StringConstant.getpercentage(widget.myReviewsModal.location),
                         center: new Text(
                           widget.myReviewsModal.location.toString(),
                           style:
                           new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                         ),
                         circularStrokeCap: CircularStrokeCap.butt,
                         backgroundColor: ColorClass.circularBgColor,
                         progressColor: ColorClass.redColor,
                         footer:  Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                               "Location",
                               style:  TextStyle(
                                   color:  ColorClass.lightTextColor,
                                   fontWeight: FontWeight.w700,
                                   fontStyle:  FontStyle.normal,
                                   fontSize: 12.0
                               ),
                               textAlign: TextAlign.left
                           ),
                         ),
                       ),

                       CircularPercentIndicator(
                         radius: 40.0,
                         animation: true,
                         animationDuration: 1200,
                         lineWidth: 3.5,
                         percent: StringConstant.getpercentage(widget.myReviewsModal.value),
                         center: new Text(
                           widget.myReviewsModal.value.toString(),
                           style:
                           new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                         ),
                         circularStrokeCap: CircularStrokeCap.butt,
                         backgroundColor: ColorClass.circularBgColor,
                         progressColor: Colors.yellow,
                         footer:  Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                               "Value",
                               style:  TextStyle(
                                   color:  ColorClass.lightTextColor,
                                   fontWeight: FontWeight.w700,
                                   fontStyle:  FontStyle.normal,
                                   fontSize: 12.0
                               ),
                               textAlign: TextAlign.left
                           ),
                         ),
                       ),
                       CircularPercentIndicator(
                         radius: 40.0,
                         animation: true,
                         animationDuration: 1200,
                         lineWidth: 3.5,
                         percent: StringConstant.getpercentage(widget.myReviewsModal.management),
                         center: new Text(
                           widget.myReviewsModal.management.toString(),
                           style:
                           new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                         ),
                         circularStrokeCap: CircularStrokeCap.butt,
                         backgroundColor: ColorClass.circularBgColor,
                         progressColor: Colors.purple,
                         footer:  Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text(
                               "Management",
                               style:  TextStyle(
                                   color:  ColorClass.lightTextColor,
                                   fontWeight: FontWeight.w700,

                                   fontStyle:  FontStyle.normal,
                                   fontSize: 12.0
                               ),
                               textAlign: TextAlign.left
                           ),
                         ),
                       ),
                     ],
                   )
               ),

               SizedBox(height: 20,),
               Text("Review",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,
                   fontSize: 16),),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text(widget.myReviewsModal.review,style:  TextStyle(
                     color:Colors.black87,
                     fontWeight: FontWeight.w400,
                     fontStyle: FontStyle.normal,
                     fontSize: 12.0,wordSpacing: 2,letterSpacing: 0.3
                 ),
                     textAlign: TextAlign.left
                 ),
               ),



               SizedBox(height: 20,),

               Text("Pros",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,
                 fontSize: 16,
                 fontStyle:  FontStyle.normal,
               ),),
               ListView.builder(
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context,index){
                   return Text("- "+widget.myReviewsModal.pros[index],
                     style:  TextStyle(
                         color:ColorClass.lightTextColor,
                         fontWeight: FontWeight.w400,
                         fontStyle: FontStyle.normal,
                         fontSize: 12.0,wordSpacing: 2,letterSpacing: 0.3
                     ),);
                 },shrinkWrap: true,
                 itemCount: widget.myReviewsModal.pros.length,
               ),


               SizedBox(height: 20,),

               Text("Cons",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,
                 fontSize: 16,
                 fontStyle:  FontStyle.normal,
               ),),
               ListView.builder(
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context,index){
                   return Text("- "+widget.myReviewsModal.cons[index],
                     style:  TextStyle(
                         color:ColorClass.lightTextColor,
                         fontWeight: FontWeight.w400,
                         fontStyle: FontStyle.normal,
                         fontSize: 12.0,wordSpacing: 2,letterSpacing: 0.3
                     ),);
                 },shrinkWrap: true,
                 itemCount:widget.myReviewsModal.cons.length,
               ),


             ])),
           ) ]),
      )

    );
  }
}