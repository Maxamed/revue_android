
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/Service/ServerDetails.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/StringConstant.dart';
import 'package:revue_mobile/reviews/widgets/bathroom_widget.dart';
import 'package:revue_mobile/reviews/widgets/bedroom_widget.dart';
import 'package:revue_mobile/reviews/widgets/floorplan_widget.dart';
import 'package:revue_mobile/reviews/widgets/price_widget.dart';
import 'package:revue_mobile/reviews/widgets/rating_widget.dart';
import 'package:revue_mobile/reviews/widgets/reviewdate_widget.dart';
import 'package:share/share.dart';

class RevueDetail  extends StatefulWidget{
  ReviewModal reviewModal ;
  int totalReview;


  RevueDetail(this.reviewModal,this.totalReview);

  @override
  State<StatefulWidget> createState() {
   return RevueDetailState();
  }
}

class RevueDetailState extends State<RevueDetail>{


  @override
  void initState() {
    super.initState();
    print(widget.reviewModal.images.length);
  }

double getPercentage(double value){
    double percent = value/10;
    return percent;
}


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
navigationBar: CupertinoNavigationBar(backgroundColor: Colors.grey.shade50,
    leading: GestureDetector(
  child: Icon(CupertinoIcons.back,size: 20,),onTap: (){ Navigator.pop(context);},)),
      child: Container(
        color: Colors.white,
      width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
            // Align(alignment: Alignment.topLeft,
            //   child: TextButton.icon(onPressed: (){
            //
            //   }, icon: Icon(Icons.arrow_back_ios_outlined,color:Colors.black,size: 18,),
            //       label: Text(
            //           "BACK",
            //           style:  TextStyle(
            //               color:   ColorClass.darkTextColor,
            //               fontWeight: FontWeight.w600,
            //               fontStyle:  FontStyle.normal,
            //               fontSize: 15.0
            //           ),
            //           textAlign: TextAlign.left
            //       ),),),
            Container(
              alignment: Alignment.center,
              child: CircularPercentIndicator(
                radius: 50.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 4.5,
                percent:StringConstant.getpercentage(widget.reviewModal.rating),
                center: new Text(
                  widget.reviewModal.rating.toString(),
                  style:
                  new TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: ColorClass.circularBgColor,
                progressColor: ColorClass.redColor,
                footer: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Overall Rating",
                      style:  TextStyle(
                          color:ColorClass.darkTextColor  ,
                          fontWeight: FontWeight.w600,

                          fontStyle:  FontStyle.normal,
                          fontSize: 12.0
                      ),
                      textAlign: TextAlign.left
                  ),
                ) ,
              )
            ),

            Container(
                height: 100,alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 40.0,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 3.5,
                        percent: StringConstant.getpercentage(widget.reviewModal.facilities),
                        center: new Text(
                            widget.reviewModal.facilities.toString(),
                          style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: ColorClass.circularBgColor,
                        progressColor: Colors.orange,
                        footer: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Facilites",overflow: TextOverflow.ellipsis,
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
                        percent: StringConstant.getpercentage(widget.reviewModal.design),
                        center: new Text(
                            widget.reviewModal.design.toString(),
                          style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: ColorClass.circularBgColor,
                        progressColor: Colors.blue,
                        footer:  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Design",overflow: TextOverflow.ellipsis,
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
                        percent: StringConstant.getpercentage(widget.reviewModal.location),
                        center: new Text(
                            widget.reviewModal.location.toString(),
                          style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: ColorClass.circularBgColor,
                        progressColor: ColorClass.redColor,
                        footer:  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Location",overflow: TextOverflow.ellipsis,
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
                        percent: StringConstant.getpercentage(widget.reviewModal.value),
                        center: new Text(
                          widget.reviewModal.value.toString(),
                          style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: ColorClass.circularBgColor,
                        progressColor: Colors.yellow,
                        footer:  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Value",overflow: TextOverflow.ellipsis,
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
                        percent: StringConstant.getpercentage(widget.reviewModal.management),
                        center: new Text(
                          widget.reviewModal.management.toString(),
                          style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: ColorClass.circularBgColor,
                        progressColor: Colors.purple,
                        footer:  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Management",overflow: TextOverflow.ellipsis,
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
                  ),
                )
            ),


            Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 10),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height:200,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return new Image.network(
                       ServerDetails.get_images+widget.reviewModal.images[index],
                        fit: BoxFit.fill,
                      );
                    },
                    autoplay: false,
                    itemCount: widget.reviewModal.images.length,
                    pagination: new SwiperPagination(),

                  ),
                ),
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
                  PriceWidget(widget.reviewModal.price),
                  BedRoomWidget(widget.reviewModal.bathRooms.toString()),
                  // RatingWidget(2,widget.reviewModal.rating)
                ],),
              ),
              Flexible(
                fit: FlexFit.tight,flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  FloorPlanWidget(widget.reviewModal.floorplan),
                  BathRoomWidget(widget.reviewModal.bathRooms.toString()),
                  // ReviewDateWidget(widget.reviewModal.reviewDate)

                ],),
              )
            ],),
            SizedBox(height: 10,),
            Divider(
              color: ColorClass.greyColor,
              thickness: 0.5,height: 2,
            ),

            SizedBox(height: 15,),

            Text("Review",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,
            fontSize: 16),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.reviewModal.review,
                  style:  TextStyle(
                  color:Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0,wordSpacing: 1,letterSpacing: 0.2
                  ),
                  textAlign: TextAlign.left
              ),
            ),

            SizedBox(height: 20,),


            Text("Pros",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,
                fontSize: 16,
              fontStyle:  FontStyle.normal,
            ),),

            Container(
              // margin: EdgeInsets.only(top: 10,bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return Text("- "+widget.reviewModal.pros[index],
                      style:  TextStyle(
                            color:Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0,wordSpacing: 2,letterSpacing: 0.3
                      ),);
                  },shrinkWrap: true,
                  itemCount: widget.reviewModal.pros.length,
                ),
              ),
            ),

            SizedBox(height: 20,),

            Text("Cons",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,
                fontSize: 16,
              fontStyle:  FontStyle.normal,
            ),),

            Container(
              // margin: EdgeInsets.only(top: 10,bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return Text("- "+widget.reviewModal.cons[index],
                      style:  TextStyle(
                          color:Colors.black87,
                          fontWeight: FontWeight.w500,

                          fontStyle: FontStyle.normal,
                          fontSize: 12.0,wordSpacing: 2,letterSpacing: 0.3
                      ),);
                  },shrinkWrap: true,
                  itemCount:widget.reviewModal.cons.length,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Divider(
              color: ColorClass.greyColor,
              thickness: 0.5,height: 2,
            ),

            SizedBox(height: 20,),
            // Padding(
            //   padding: const EdgeInsets.all(5.0),
            //   child:
            //   Row(
            //     children: [
            //       Icon(
            //         Icons.thumb_up,
            //         color: Colors.yellow,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: AutoSizeText("Was this review helpful?",
            //             style: const TextStyle(
            //                 color: Colors.black,
            //
            //                 fontWeight: FontWeight.w500,
            //                 fontStyle: FontStyle.normal,
            //                 fontSize: 16.0),
            //             textAlign: TextAlign.left),
            //       ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Webservice.reportReviewRequest(context,
                          widget.reviewModal.id).then((value) => this.setState(() {

                      }));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.flag_rounded,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AutoSizeText("Report",
                              style: const TextStyle(
                                  color: Colors.black,

                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                   GestureDetector(
                        onTap: (){
                          Share.share("Check out this property https://revueapp.com/property");
                        },
                        child: Icon(
                          Icons.share_outlined,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AutoSizeText("Share",
                            style: const TextStyle(
                                color: Colors.black,

                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                ],
              ),
            ),




          ],),
        ),
      ),
    );
  }
}