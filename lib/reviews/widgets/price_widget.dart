import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class PriceWidget extends StatelessWidget{
  String price = "";

  PriceWidget(this.price);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(4.0),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          children: [
            AutoSizeText(
                "Price : ",
                style: TextStyle(
                    color:  ColorClass.darkTextColor,
                    fontWeight: FontWeight.w700,
                    fontStyle:  FontStyle.normal,
                    fontSize: 14.0
                ),
                textAlign: TextAlign.left
            ),
            AutoSizeText(
                " $price / month",
                style:  TextStyle(
                    color:Colors.black87,
                    fontWeight: FontWeight.w500,
                    fontStyle:  FontStyle.normal,
                    fontSize: 12.0
                ),
                textAlign: TextAlign.left
            ),
          ],
        ),
      ),
    );
  }

}