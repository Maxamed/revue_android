import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class RatingWidget extends StatelessWidget{
final  int totalReview;
 final double totalRating;

  RatingWidget(this.totalReview,this.totalRating);

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(4.0),
      child: FittedBox(fit: BoxFit.fitWidth,
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            // GFRating(
            //   size: 20,
            //   value: valueRating,
            //   color: Colors.yellow,
            //   borderColor: Colors.yellow,
            //   onChanged: (value) {
            //     setState(() {
            //       valueRating = value;
            //     });
            //   },
            // ),


            Text(
                "Rating : $totalRating",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    fontStyle:  FontStyle.normal,
                    fontSize: 14.0
                ),
                textAlign: TextAlign.left
            ),

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                  " ($totalReview reviews)",
                  style: TextStyle(
                      color: ColorClass.greyColor,
                      fontStyle:  FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0
                  ),
                  textAlign: TextAlign.left
              ),
            ),
          ],
        ),
      ),
    );
  }
}