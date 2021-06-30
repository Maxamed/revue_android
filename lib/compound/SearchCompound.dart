import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revue_mobile/Modal/CompoundModal.dart';
import 'package:revue_mobile/Modal/SearchModal.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/compound/CompoundDetails.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';

import '../constant/ColorClass.dart';

class SearchCompound extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchCompoundState();
  }
}
List compoundSearchList = [];
class SearchCompoundState extends State<SearchCompound>{
  TextEditingController searchController =TextEditingController();
  // List searchableitem=[];


  SearchModal searchModal;


  searchRequest(){

  }


  @override
  void initState() {
    super.initState();
    searchModal = new SearchModal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        leading:
        IconButton(color: Colors.black,icon: Icon(CupertinoIcons.back),
          onPressed: (){Navigator.pop(context);},),),
      bottomNavigationBar: new Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 30),
            height: 50
            ,child: SizedBox(
            width: 300,height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: ColorClass.blueColor,
                  padding: EdgeInsets.all(10),
                ),

                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Done",style: TextStyle(fontSize: 16,color:  Colors.white,),),

              ),
            ),
          ),
         ],

      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10,right: 8,left: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Material(
               elevation: 5,
                type: MaterialType.card,  shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                child:CupertinoTextField(
                  decoration: BoxDecoration(color: Colors.white),
                  controller: searchController,
                  placeholder: "Building, Compound or Cities",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  placeholderStyle: TextStyle(color: ColorClass.lightTextColor,fontSize: 18),
                  suffix: searchController.text.isNotEmpty?
                      IconButton(icon: Icon(CupertinoIcons.clear_circled,
                        color: ColorClass.lightTextColor,),onPressed: (){
                        searchController.clear();
                        compoundSearchList.clear();
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
                      print(string);
                      // searchableitem.clear();
                      searchModal.string = string;
                      Webservice.searchCompoundRequest(searchModal).then((value) => this.setState(() {

                        // compoundSearchList.forEach((element) {
                        //   if(compoundSearchList.contains(element)){
                        //     searchableitem.add(element);
                        //     setState(() {});
                        //   }else{
                        //     searchableitem.remove(element);
                        //   }
                        //
                        // });

                      }));
                    }else{
                      compoundSearchList.clear();setState(() {

                      });
                    }

                  },
                )
              ),
              SizedBox(height: 20,),
              ListView.builder(shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>

                        CompoundDetails(compoundDetailsKey: GlobalKeys.compoundDetailsKey,compoundID: (compoundSearchList[index] as CompoundModal).id,
                           compound:  compoundSearchList[index] as CompoundModal)));
                  },behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text((compoundSearchList[index] as CompoundModal).compoundname,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.w700,color: ColorClass.lightTextColor),),
                        Text((compoundSearchList[index] as CompoundModal).address,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w400,color: ColorClass.lightTextColor),),

                        Divider(color: ColorClass.greyColor,)
                      ],
                    ),
                  ),
                );
              },itemCount: compoundSearchList.length,),
              // Expanded(child: Align
              //   (alignment: Alignment.center,
              //     child: Image.asset("assets/images/gps.png",
              //       width: 30,height: 30,fit: BoxFit.fill,))),

            ],
          ),
        ),
      ),
    );
  }

}
