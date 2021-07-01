import 'package:flutter/material.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class AmenitiesGridClass extends StatelessWidget{
  List amentitiesList = [];


  AmenitiesGridClass(this.amentitiesList);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: GridView.builder(
          shrinkWrap: true,itemCount: amentitiesList.length,physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,childAspectRatio: 8,
          ),
          itemBuilder: (BuildContext context,index){
        return Text(amentitiesList[index],
          style: TextStyle(color: Colors.black,fontSize: 12,
            fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,),);
          }),
    );
  }
}