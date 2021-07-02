import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revue_mobile/Modal/QuestionModal.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';

import 'QuestionAnswerScreen.dart';

class SearchQuestion extends StatefulWidget{

  List qList =[];
  String compoundID;
  String compoundName;

  SearchQuestion(this.qList,this.compoundID,this.compoundName);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
  return SearchQuestionState();
  }
}

class SearchQuestionState extends State<SearchQuestion>{
  TextEditingController searchController = TextEditingController();
  List searchList =[];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
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
     body: SingleChildScrollView(
       child: Column(
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Material(
                 elevation: 5,
                 type: MaterialType.card,  shadowColor: Colors.grey,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                 child:Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: CupertinoTextField(
                     decoration: BoxDecoration(color: Colors.white),
                     controller: searchController,
                     placeholder: "Have a Question? Search Here",
                     keyboardType: TextInputType.text,
                     textInputAction: TextInputAction.search,
                     placeholderStyle: TextStyle(color: ColorClass.lightTextColor,fontSize: 16),
                     suffix: searchController.text.isNotEmpty?
                     IconButton(icon: Icon(CupertinoIcons.clear_circled,
                       color: ColorClass.lightTextColor,),onPressed: (){
                       searchController.clear();
                       searchList.clear();
                       setState(() {

                       });
                     },)
                         :null,
                     prefix:  Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Icon(CupertinoIcons.search,size: 25,color: ColorClass.blueColor,),
                     ),style: TextStyle(color: ColorClass.darkTextColor,fontSize: 17),
                     clearButtonMode: OverlayVisibilityMode.editing,
                     onChanged: (string){
                       searchList.clear();
                       if(string.length>3){
                         widget.qList.forEach((element) {
                           if((element as QuestionModal).question.contains(string)){
                             searchList.add(element);
                             print(element);
                             setState(() {

                             });
                           }
                         });
                         print(string);
                       }

                     },
                   ),
                 )
             ),
           ),
           SizedBox(height: 20,),

           ListView.builder(itemBuilder: (context,index){
             return Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: GestureDetector(
                     behavior: HitTestBehavior.translucent,
                     onTap: (){
                       Navigator.push(context,MaterialPageRoute(builder: (context)=>
                           QuestionAnswerScreen(key: GlobalKeys.addAswerKey,compoundID: widget.compoundID,
                               compoundName: widget.compoundName,
                              questionModal:  searchList[index] as QuestionModal)));
                     },
                     child: Text((searchList[index] as QuestionModal).question,
                       style: TextStyle(color: ColorClass.darkTextColor,fontSize: 14,
                       fontWeight: FontWeight.w500
                       ),textAlign: TextAlign.center,),
                   ),
                 ),

                 Divider(color: ColorClass.borderColor,thickness: 1,height: 2,)
               ],
             );
           },itemCount: searchList.length,
             shrinkWrap: true,
             physics: AlwaysScrollableScrollPhysics(),)


         ],
       ),
     ),
   );
  }
}