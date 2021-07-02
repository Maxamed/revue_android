import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:revue_mobile/Modal/AnswerModal.dart';
import 'package:revue_mobile/Modal/MessagingModal.dart';
import 'package:revue_mobile/Modal/QuestionModal.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';
import 'package:revue_mobile/constant/StringConstant.dart';
import 'package:revue_mobile/messages/QuestionAnswerScreen.dart';
import 'package:revue_mobile/messages/SearchQuestionWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/ColorClass.dart';

class MessagingScreen extends StatefulWidget{
  String compoundID;
  String compoundName;
  String address;


  MessagingScreen({Key key,this.compoundID, this.compoundName,this.address}):super(key: key);

  @override
  State<StatefulWidget> createState() {
   return MessagingScreenState();
  }
}

class MessagingScreenState extends State<MessagingScreen>{
  TextEditingController questionController = TextEditingController();
  List questionsList = [];

  @override
  void initState() {
    super.initState();
   getAllQuestions();
  }

  getAllQuestions(){
    Webservice.getAllRequestedQuestions(questionsList, widget.compoundID).then((value) => this.setState(() {

    }));
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(body:  Scaffold(
      bottomNavigationBar: new Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,margin: EdgeInsets.only(left: 40,right: 40,bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: ColorClass.blueColor,
                padding: EdgeInsets.all(10),
              ),

              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(5),
                      topRight:Radius.circular(5), )),
                    builder: (context) => postQuestion(context));
              },

              child: Text(
                "Write your question",
                style: TextStyle(fontSize: 16,color: Colors.white),
              ),

            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(backgroundColor: Colors.white,
            largeTitle:
            Text(widget.compoundName, style:  TextStyle(
                color: ColorClass.darkTextColor,
                fontWeight: FontWeight.w600,
                fontStyle:  FontStyle.normal,
                fontSize: 20.0
            ),
                textAlign: TextAlign.left
            ),automaticallyImplyLeading: false,leading:
              GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.chevron_left,
                    color: Colors.black,size: 20,
                  )),),

          CupertinoSliverRefreshControl(

            onRefresh:(){
              return new Future<void>.delayed(const Duration(seconds: 2))
                ..then((_) {
                 getAllQuestions();
                });

            },
          ),


          SliverToBoxAdapter(
            child: Column(
              // shrinkWrap: true,
              // physics: AlwaysScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 5,right: 5,bottom: 5),
                  child: Row(
                    children: [
                      Icon(CupertinoIcons.location_solid,size: 25,),
                      SizedBox(width: 10,),
                      // Southwest apartments, Green community West,Green C
                      Flexible(
                        child: Text(
                          widget.address,
                          style:  TextStyle(
                              color:  ColorClass.lightTextColor,
                              fontWeight: FontWeight.w600,
                              fontStyle:  FontStyle.normal,
                              fontSize: 12.0
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],),
                ),

                Container(
                  margin:
                  EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: ColorClass.borderColor, width: 1)),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>
                              SearchQuestion(questionsList,widget.compoundID,widget.compoundName)));
                      // showCupertinoModalBottomSheet(
                      //     barrierColor: Colors.white,
                      //     backgroundColor: ColorClass.whiteColor,shape: RoundedRectangleBorder
                      //   (borderRadius:BorderRadius.all(Radius.circular(10))),
                      //     context: context, builder: (context)=>SearchQuestion(questionsList));
                     },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.search,
                            size: 25,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: // Questions
                            Text(
                                "Search Questions",
                                style:  TextStyle(
                                    color:  ColorClass.lightTextColor,
                                    fontWeight: FontWeight.w400,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                ),
                                textAlign: TextAlign.left
                            )),
                      ],
                    ),
                  ),
                ),
                Container(
                  child:
                  questionsList.isEmpty?
                  Text("No Questions Posted"):

                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: questionsList.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>
                              QuestionAnswerScreen(key: GlobalKeys.addAswerKey,compoundID: widget.compoundID,compoundName: widget.compoundName,
                                 questionModal:  (questionsList[index] as QuestionModal))));

                         setState(() {

                         });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                            // Q.Water facilities good or not?
                            Text(
                                "Q${index+1}. ${(questionsList[index] as QuestionModal).question} ?",
                                style:  TextStyle(
                                    color:  ColorClass.darkTextColor,
                                    fontWeight: FontWeight.w600,
                                    fontStyle:  FontStyle.normal,
                                    fontSize: 16.0
                                ),
                                textAlign: TextAlign.left
                            ),
                            answerWidget((questionsList[index] as QuestionModal).answerList),
                            SizedBox(height: 10,),
                            Divider(color: ColorClass.borderColor,height: 1,thickness: 1,)
                          ],),
                        ),
                      );
                    },
                  ),
                )

              ],),
          )
        ],
      ),
    ));
  }


  Widget postQuestion(BuildContext context){

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
              padding: const EdgeInsets.only(top: 20,bottom: 20),
              child: Text(
                  "Post your question",
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
              margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/input.png")
                  )
              ),
              child: TextField(textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                controller: questionController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: "Write your question here",
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
              child: Text(
                  "Your question might be answered by any user who lived there",
                  style:  TextStyle(
                      color: ColorClass.lightTextColor,
                      fontWeight: FontWeight.w400,
                      fontStyle:  FontStyle.normal,
                      fontSize: 14.0
                  ),
                  textAlign: TextAlign.left
              ),
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
                        primary: ColorClass.inactiveIconColor,
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 14,color: Colors.white),
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
                       primary: ColorClass.blueColor,
                      ),
                      onPressed: () async{

                        SharedPreferences pref = await SharedPreferences.getInstance();
                        MessagingModal messaging = new MessagingModal();
                        messaging.question = questionController.text;
                        messaging.userName = pref.getString("name");
                        messaging.userID = pref.getString("userID");
                        messaging.compoundID = widget.compoundID;
                        messaging.compoundName = widget.compoundName;
                        messaging.timestamp = DateTime.now().millisecondsSinceEpoch;

                        Webservice.postQuestionRequest(context, messaging).then((value) => this.setState(() {
                          questionController.text="";
                        }));

                      },
                      child: Text(
                        "Post",
                        style: TextStyle(fontSize: 14,color: Colors.white,),
                      ),),
                  ),
                ],),
              ),
            ),)
          ],),
        ),
      ),
    );
  }


  Widget answerWidget(List ansList){
    return SizedBox(
      child: Column(children: [
        ansList.isEmpty?
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No answers",style:TextStyle(
                  color:    ColorClass.greyColor,
                  fontWeight: FontWeight.w500,
                  fontStyle:  FontStyle.normal,
                  fontSize: 15.0
              ),),
            ):
        ListView.builder(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
            itemCount:1,
            itemBuilder: (context,ind){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "A. ${(ansList[ind] as AnswerModal).answer}",
                style:  TextStyle(
                    color:   ColorClass.darkTextColor,
                    fontWeight: FontWeight.w600,
                    fontStyle:  FontStyle.normal,
                    fontSize: 15.0
                ),
                textAlign: TextAlign.left
            ),
          ),

            Row(children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Row(
                  children: [
                    Icon(CupertinoIcons.person_circle_fill,color: Colors.grey,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "${(ansList[ind] as AnswerModal).userName}",
                          style:  TextStyle(
                              color:   ColorClass.greyColor,
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
                  StringConstant.getReviewPostedDate((ansList[ind] as AnswerModal).timestamp),
                  style:  TextStyle(
                      color:  ColorClass.lightTextColor,
                      fontWeight: FontWeight.w400,
                      fontStyle:  FontStyle.normal,
                      fontSize: 15.0
                  ),
                  textAlign: TextAlign.left
              ),)
            ],),],);
            })



      ],),
    );
  }

}
