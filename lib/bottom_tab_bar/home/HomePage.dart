
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:revue_mobile/bottom_tab_bar/SearchWidget.dart';
import 'package:revue_mobile/bottom_tab_bar/home/CompoundList.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return HomePageState();
  }
}


class HomePageState extends State<HomePage>{

  bool isLoading = false;
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          SearchWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (notification){
                print(notification.metrics.pixels);
                if (notification.metrics.maxScrollExtent ==
                    notification.metrics.pixels) {
                  GlobalKeys.compoundListKey.currentState.updateCompounds();
                }
              },
              child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5,left: 10,right: 10),
                    child: Text(
                        "Homes Around You",
                        style:  TextStyle(
                            color:  ColorClass.blueColor,
                            fontWeight: FontWeight.w600,
                            fontStyle:  FontStyle.normal,
                            fontSize: 18.0
                        ),
                        textAlign: TextAlign.left
                    ),
                  ),

                  CompoundList(compoundListKey:GlobalKeys.compoundListKey ,)


                ],),
            ),
          ),
        ],
      ),
    );
  }


  
}
