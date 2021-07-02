import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:revue_mobile/Modal/AnswerModal.dart';
import 'package:revue_mobile/Modal/LikeUnlikeModal.dart';
import 'package:revue_mobile/Modal/QuestionModal.dart';
import 'package:revue_mobile/Modal/ReportModal.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/constant/StringConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/ColorClass.dart';

// ignore: must_be_immutable
class QuestionAnswerScreen extends StatefulWidget{
  String compoundID;
  String compoundName;
  QuestionModal questionModal;
  QuestionAnswerScreen({Key key,this.compoundID, this.compoundName,this.questionModal}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    return QuestionAnswerScreenState();
  }
}

class QuestionAnswerScreenState extends State<QuestionAnswerScreen>{



  TextEditingController answerController = TextEditingController();


  List answerList =[];

  @override
  void initState() {

    super.initState();
    getAllAnswers();
  }
  getAllAnswers(){
    Webservice.getAllAnswersRequest(answerList, widget.questionModal.id).then((value) => this.setState(() {

    }));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(50),child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading:
        GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.chevron_left,
              color: Colors.black,
            )),
      ),),

      bottomNavigationBar: new Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,margin: EdgeInsets.only(left: 40,right: 40,bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorClass.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(10),

              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight:Radius.circular(5), )),
                    builder:(context) => postAnswer(context));
                // (BuildContext context,ScrollController controller){
                //       return ;
                //     }
                // );
              },
              child: Text(
                "Write your Answer",
                style: TextStyle(fontSize: 16,color: Colors.white,),
              ),

            ),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              "Q1. ${widget.questionModal.question}",
              style:  TextStyle(
                  color: ColorClass.darkTextColor,
                  fontWeight: FontWeight.w600,
                  fontStyle:  FontStyle.normal,
                  fontSize: 20.0
              ),
              textAlign: TextAlign.left
          ),
        ),
        Divider(color: ColorClass.borderColor,height: 5,thickness: 1,),

        SizedBox(height: 10,),


        answerList.isEmpty?
        Text("Currently no answers posted",
            style:TextStyle(color: ColorClass.lightTextColor,)):
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: answerList.length,
          itemBuilder: (context,index){
            AnswerModal answer = answerList[index] as AnswerModal;
            return Container(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "A. ${answer.answer}",
                      style:  TextStyle(
                          color:  ColorClass.darkTextColor,
                          fontWeight: FontWeight.w600,
                          fontStyle:  FontStyle.normal,
                          fontSize: 17.0
                      ),
                      textAlign: TextAlign.left
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Row(children: [
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.person_circle_fill,color:ColorClass.greyColor,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                answer.userName+"......",
                                style:  TextStyle(
                                    color:  ColorClass.darkTextColor,
                                    fontWeight: FontWeight.w500,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 15.0
                                ),
                                textAlign: TextAlign.left
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(fit: FlexFit.tight,flex: 1,child: // 1 Month ago
                    Text(
                        StringConstant.getReviewPostedDate(
                            answer.timestamp),
                        style: TextStyle(
                            color:  ColorClass.greyColor,
                            fontWeight: FontWeight.w400,
                            fontStyle:  FontStyle.normal,
                            fontSize: 14.0
                        ),
                        textAlign: TextAlign.end
                    ),)
                  ],),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    // Helpful?
                    Row(
                      children: [
                        Text(
                            "Helpful?",
                            style:  TextStyle(
                                color:  ColorClass.greyColor,
                                fontWeight: FontWeight.w400,
                                fontStyle:  FontStyle.normal,
                                fontSize: 14.0
                            ),
                            textAlign: TextAlign.left
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(children: [
                            IconButton(

                              icon: answer.isLiked==true
                                  ? Icon(CupertinoIcons.hand_thumbsup_fill,
                                color: ColorClass.redColor,)
                                  : Icon(CupertinoIcons.hand_thumbsup_fill,
                                color: ColorClass.darkTextColor,) ,
                              onPressed: () async{
                                // setState(() {
                                //   _likes[index] = !_likes[index];
                                // });

                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                LikeUnlikeModal likeUnlike = new LikeUnlikeModal();
                                likeUnlike.id = answer.id;
                                likeUnlike.userID = prefs.getString("userID");

                                if(answer.isLiked){
                                  likeUnlike.operation = -1;
                                  (answerList[index] as AnswerModal).like -=1;
                                  (answerList[index] as AnswerModal).isLiked = false;

                                }else{
                                  likeUnlike.operation = 1;
                                  (answerList[index] as AnswerModal).like +=1;
                                  (answerList[index] as AnswerModal).isLiked =true;

                                  if(answer.isDisLiked){
                                    (answerList[index] as AnswerModal).isDisLiked = false;
                                    (answerList[index] as AnswerModal).dislike -= 1;
                                  }

                                }
                                Webservice.likeUnlikeRequest(context, likeUnlike);
                                setState(() {

                                });
                              },),

                            Text(answer.like.toString() )
                          ],),
                        ),

                        Row(children: [
                          IconButton(
                            icon: answer.isDisLiked == true
                                ? Icon(CupertinoIcons.hand_thumbsdown_fill,
                              color: ColorClass.redColor,)
                                : Icon(CupertinoIcons.hand_thumbsdown_fill,
                              color:ColorClass.darkTextColor,) ,
                            onPressed: () async{

                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              LikeUnlikeModal likeUnlike = new LikeUnlikeModal();
                              likeUnlike.id = (answerList[index] as AnswerModal).id;
                              likeUnlike.userID = prefs.getString("userID");
                              if(answer.isDisLiked){
                                likeUnlike.operation = -2;
                                (answerList[index] as AnswerModal).dislike -=1;
                                (answerList[index] as AnswerModal).isDisLiked = false;


                              }else{
                                likeUnlike.operation = 2;
                                (answerList[index] as AnswerModal).dislike +=1;
                                (answerList[index] as AnswerModal).isDisLiked =true;
                                if(answer.isLiked){
                                  (answerList[index] as AnswerModal).isLiked = false;
                                  (answerList[index] as AnswerModal).like -= 1;
                                }



                              }
                              Webservice.likeUnlikeRequest(context, likeUnlike);
                              setState(() {

                              });

                            },),
                          Text(
                              answer.dislike.toString()  )
                        ],)

                      ],
                    ),


                    // Report
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        showMaterialModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                              topRight:Radius.circular(5), )),
                            builder: (context) =>
                                reportAnswerWidget(answer.id));
                      },

                      child: Text(
                          "Report",
                          style:  TextStyle(
                              color:  ColorClass.darkTextColor,
                              fontWeight: FontWeight.w600,
                              fontStyle:  FontStyle.normal,
                              fontSize: 14.0
                          ),
                          textAlign: TextAlign.left
                      ),
                    )

                  ],),
                ),

                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 5),
                  child: Divider(color: Color(0x33000000),height: 1,thickness: 1,),
                )

              ],),);
          },

        )
      ],)
    ));
  }



  Widget postAnswer(BuildContext context){
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        color: Color(0xfffaf7f7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: Text(
                  "Write your Answer",
                  style:  TextStyle(
                      color:  ColorClass.darkTextColor,
                      fontWeight: FontWeight.w600,
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0
                  ),
                  textAlign: TextAlign.left
              ),
            ),

            Container(
              height: 50,width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/input.png")
                  )
              ),
              child: TextField(textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                controller: answerController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: "Write your answer here",
                    hintStyle: TextStyle(
                      color: Color(0x7f3c2f47),
                      fontSize: 18,

                    ),
                    border: InputBorder.none,
                    fillColor: Colors.white
                ),),
            ),

            Padding(
              padding:EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              child: // Your answer will shown among the oyher answer.
              Text(
                  StringConstant.answer,
                  style:  TextStyle(
                      color:  ColorClass.lightTextColor,
                      fontWeight: FontWeight.w400,
                      fontStyle:  FontStyle.normal,
                      fontSize: 14.0
                  ),
                  textAlign: TextAlign.left
              )
            ),

            Expanded(child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 40,width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary: ColorClass.inactiveIconColor,
                          padding: EdgeInsets.all(10),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 16,color:Colors.white),
                        ),

                      ),
                    ),
                    Container(
                      height: 40,width: 150,
                      margin: EdgeInsets.only(left: 10),

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          primary:  ColorClass.blueColor,
                          padding: EdgeInsets.all(10),
                        ),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          AnswerModal answerModal = new AnswerModal();
                          answerModal.answer = answerController.text;
                          answerModal.timestamp = DateTime.now().millisecondsSinceEpoch;
                          answerModal.compoundID = widget.compoundID;
                          answerModal.userID = prefs.getString("userID");
                          answerModal.userName = prefs.getString("name");
                          answerModal.questionID = widget.questionModal.id;
                          Webservice.postAnswerRequest(context, answerModal);

                        },
                        child: Text(
                          "Post",
                          style: TextStyle(fontSize: 16,color:  Colors.white,),
                        ),

                      ),
                    ),
                  ],),
              ),
            ),)
          ],),
        ),
      ),
    );
  }

  Widget reportAnswerWidget(String id){
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      color: Color(0xfffaf7f7),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
// Post your question
          Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10,left: 10),
              child: // Report
              Text(
                  "Report",
                  style:  TextStyle(
                      color: ColorClass.darkTextColor,
                      fontWeight: FontWeight.w600,
                      fontStyle:  FontStyle.normal,
                      fontSize: 20.0
                  ),
                  textAlign: TextAlign.left
              )
          ),

          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),

              child: // If you find this content inappropriate and think i
              Text(StringConstant.report,
                  style:  TextStyle(
                      color:  ColorClass.lightTextColor,
                      fontWeight: FontWeight.w400,
                      fontStyle:  FontStyle.normal,
                      fontSize: 14.0
                  ),
                  textAlign: TextAlign.left
              )
          ),


          Expanded(child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 40,width:300,
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorClass.blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                ),

                onPressed: () async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  ReportModal report = new ReportModal();
                  report.answerID = id;
                  report.userID = prefs.getString("userID");
                  report.userName = prefs.getString("name");

                  Webservice.reportAnswerRequest(context, report);
                },

                child: Text(
                  "Report",
                  style: TextStyle(fontSize: 16,color: Colors.white,),
                ),

              ),
            ),
          ),)
        ],),
      ),
    );
  }

}
