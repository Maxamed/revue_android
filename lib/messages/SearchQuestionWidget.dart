import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revue_mobile/Modal/QuestionModal.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class SearchQuestion extends StatefulWidget{

  List qList =[];

  SearchQuestion(this.qList);

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
     body: SingleChildScrollView(
       child: Column(
         children: [
           Material(
               elevation: 5,
               type: MaterialType.card,  shadowColor: Colors.grey,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
               child:CupertinoTextField(
                 decoration: BoxDecoration(color: Colors.white),
                 controller: searchController,
                 placeholder: "Have a Question? Search Here",
                 keyboardType: TextInputType.text,
                 textInputAction: TextInputAction.search,
                 placeholderStyle: TextStyle(color: ColorClass.lightTextColor,fontSize: 18),
                 suffix: searchController.text.isNotEmpty?
                 IconButton(icon: Icon(CupertinoIcons.clear_circled,
                   color: ColorClass.lightTextColor,),onPressed: (){
                   searchController.clear();searchList.clear();
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

                   if(string.length>3){
                     widget.qList.forEach((element) {
                       if((element as QuestionModal).question.contains(string)){
                         searchList.add(element);
                       }
                     });
                     print(string);
                   }else{
                     searchList.clear();
                     setState(() {

                     });
                   }

                 },
               )
           ),

           ListView.builder(itemBuilder: (context,index){
             return Text((searchList[index] as QuestionModal).question,
               style: TextStyle(color: ColorClass.darkTextColor,fontSize: 15),);
           },itemCount: searchList.length,shrinkWrap: true,)


         ],
       ),
     ),
   );
  }
}