import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:revue_mobile/Modal/MyReviewsModal.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/StringConstant.dart';
import 'package:revue_mobile/reviews/MyReview/MyReviewDetails.dart';

class MyReviews extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyReviewsState();
  }
}

class MyReviewsState extends State<MyReviews>{
  List myReviews = [];
  bool showMore = false;

  @override
  void initState() {
    super.initState();

    Webservice.getMyReviews(myReviews).then((value) => this.setState(() {

    }));
  }

  double getPercentage(double value){
    double percent = value/10;
    return percent;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      child:CustomScrollView(
        slivers: [

        CupertinoSliverNavigationBar(backgroundColor: Colors.white,
        largeTitle:
        Text("My Reviews", style:  TextStyle(
            color: ColorClass.darkTextColor,
            fontWeight: FontWeight.w700,
            fontStyle:  FontStyle.normal,
            fontSize: 20.0
        ),
            textAlign: TextAlign.left
        ),
          automaticallyImplyLeading: false,leading:
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                CupertinoIcons.chevron_left,
                color: Colors.black,
              )),stretch: true,),
        SliverToBoxAdapter(child:  ListView.builder(shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: myReviews.length,itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: (){

                },
                child: Container(
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        Flexible(flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  (myReviews[index] as MyReviewsModal).compoundName,
                                  style: TextStyle(
                                      color:ColorClass.redColor,
                                      fontWeight: FontWeight.w600,
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 18.0
                                  ),
                                  textAlign: TextAlign.left
                              ),
                              SizedBox(height: 20,),
                              Row(children: [
                                Text("Posted On  : ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,
                                    fontSize: 14),),

                                Text(StringConstant.getReviewPostedDate( (myReviews[index] as MyReviewsModal).reviewDate),style: TextStyle(color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12))
                              ],),
                              SizedBox(height: 5,),

                            ],
                          ),),
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:   CircularPercentIndicator(
                              radius: 45.0,
                              animation: true,
                              animationDuration: 1200,
                              lineWidth: 4.0,
                              percent: StringConstant.getpercentage((myReviews[index] as MyReviewsModal).rating),
                              center: new Text(
                                (myReviews[index] as MyReviewsModal).rating.toString(),
                                style:
                                new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                              ),
                              circularStrokeCap: CircularStrokeCap.butt,
                              backgroundColor: ColorClass.circularBgColor,
                              progressColor: ColorClass.blueColor,
                              // footer: Padding(
                              //   padding: const EdgeInsets.all(4.0),
                              //   child: Text(
                              //       "Overall Rating",
                              //       style:  TextStyle(
                              //           color:ColorClass.lightTextColor  ,
                              //           fontWeight: FontWeight.w700,
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
                              fontWeight: FontWeight.w600,

                              fontStyle:  FontStyle.normal,
                              fontSize: 14.0
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text((myReviews[index] as MyReviewsModal).review,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style:  TextStyle(
                                color:  Colors.black87,
                                fontWeight: FontWeight.w400,

                                fontStyle:  FontStyle.normal,
                                fontSize: 12.0
                            ),
                            textAlign: TextAlign.left
                        ),
                      ),

                      // Container(
                      //     margin: EdgeInsets.only(top: 5,bottom: 5),
                      //     alignment: Alignment.centerRight,
                      //     child: showMore ? GestureDetector(
                      //       onTap: (){
                      //         if(myReviews[index]){
                      //           setState(() {
                      //             showMore = !showMore;
                      //           });
                      //         }
                      //
                      //       },
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         children: [
                      //           Text("READ LESS",
                      //               textAlign: TextAlign.end,
                      //               style: TextStyle(fontSize: 12,
                      //                   color: ColorClass.blueColor,fontWeight: FontWeight.w600)),
                      //           Icon(Icons.keyboard_arrow_up_outlined,color: Colors.black,)
                      //         ],
                      //       ),
                      //     ) :
                      //     GestureDetector(
                      //       onTap: (){
                      //         setState(() {
                      //           showMore = !showMore;
                      //         });
                      //       },
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         children: [
                      //           Text("READ MORE",
                      //               textAlign: TextAlign.end,
                      //               style: TextStyle(fontSize: 12,
                      //                   color: ColorClass.blueColor,fontWeight: FontWeight.w600)),
                      //           Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,)
                      //         ],
                      //       ),
                      //     )),

                      SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                          // 1350 sqft
                          Column(
                            children: [
                              Text(
                                  "Floor Plan",
                                  style:  TextStyle(
                                      color:  ColorClass.darkTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 14.0
                                  ),
                                  textAlign: TextAlign.left
                              ),
                              Text(
                                  (myReviews[index] as MyReviewsModal).floorplan + " / Sq. Ft.",
                                  style:  TextStyle(
                                      color: ColorClass.lightTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 12.0
                                  ),
                                  textAlign: TextAlign.left
                              ),
                            ],
                          ),
                          // 45000 INR
                          Column(
                            children: [
                              Text(
                                  "Rent",
                                  style:  TextStyle(
                                      color:  ColorClass.darkTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 14.0
                                  ),
                                  textAlign: TextAlign.left
                              ),
                              Text(
                                  (myReviews[index] as MyReviewsModal).price +" QAR",
                                  style:  TextStyle(
                                      color:  ColorClass.lightTextColor,
                                      fontStyle:  FontStyle.normal,
                                      fontSize: 12.0
                                  ),
                                  textAlign: TextAlign.left
                              ),
                            ],
                          ),
                          // View more
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  MyReviewDetails((myReviews[index] as MyReviewsModal))));
                            },behavior: HitTestBehavior.translucent,
                            child: Text(
                                "View More",
                                style: const TextStyle(
                                    color:  const Color(0xcc156fc2),
                                    fontWeight: FontWeight.w600,

                                    fontStyle:  FontStyle.normal,
                                    fontSize: 12.0
                                ),
                                textAlign: TextAlign.left
                            ),
                          )
                        ],),
                      ),
                      Divider(
                        color:  ColorClass.greyColor,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );

          },),)
        ])
    );
  }
}