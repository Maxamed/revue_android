import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revue_mobile/FilterScreen.dart';
import 'package:revue_mobile/compound/SearchCompound.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class SearchWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  FittedBox(fit: BoxFit.fitWidth,
      child: Padding(
        padding: const EdgeInsets.only(top: 20,left: 10,right: 10
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Material(
            elevation: 20,
            type: MaterialType.transparency ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Navigator.push(context,CupertinoPageRoute(builder: (context)=>SearchCompound()) );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(15)
                        ),
                        border: Border.all(
                            color: ColorClass.blueColor,
                            width: 1
                        ),
                        boxShadow: [
                          BoxShadow(
                              color:  Color(0x26000000),
                              offset: Offset(0,1),
                              blurRadius: 1,
                              spreadRadius: 0
                          )] ,
                        color: Colors.white
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                      // Search
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "   Search",
                            style:  TextStyle(
                                color:  ColorClass.blueColor,
                                fontWeight: FontWeight.w600,
                                fontStyle:  FontStyle.normal,
                                fontSize: 16.0
                            ),
                            textAlign: TextAlign.left
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.search,size: 20,),
                      )

                    ],),
                  ),
                ),
                Container(height: 50,width:50,
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        Navigator.push(context, CupertinoPageRoute(
                            builder: (context)=>FilterScreen()
                        ));
                      },
                      child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/filter.png",fit: BoxFit.fill,height: 20,width: 25,),
                          Text(
                              "Filter",
                              style:  TextStyle(
                                  color: ColorClass.darkTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle:  FontStyle.normal,
                                  fontSize: 12.0
                              ),
                              textAlign: TextAlign.left
                          )
                        ],),
                    )),
              ],),
          ),),
      ),
    );
  }

}
