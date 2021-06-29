import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/constant/StringConstant.dart';

class ReviewDateWidget extends StatelessWidget{
  int reviewDate;


  ReviewDateWidget(this.reviewDate);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FittedBox(fit: BoxFit.fitWidth,
        child: Column(
          children: [
            Text(
                "Review Date :",
                style:  TextStyle(
                    color:  Colors.black87,

                    fontWeight: FontWeight.w700,
                    fontStyle:  FontStyle.normal,
                    fontSize: 14.0
                ),
                textAlign: TextAlign.left
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                  StringConstant.getReviewPostedDate(reviewDate),
                  style:  TextStyle(
                      fontStyle:  FontStyle.normal,
                      fontSize: 14.0,
                      color: ColorClass.greyColor,
                      fontWeight: FontWeight.w600
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