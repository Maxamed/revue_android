import 'package:intl/intl.dart';
import 'package:revue_mobile/Modal/AmenitiesModal.dart';
import 'package:revue_mobile/Modal/CompoundModal.dart';

class StringConstant{


  static String report =   "If you find this content inappropriate and think it should be removed from this website,let us know by clicking the button below.";
  static String answer =  "Your answer will shown among the other answer.";
  static String question ="Your question might be answered by any user who lived there";

      static String getReviewPostedDate(int time){
    print(time);
    var date = DateTime.fromMillisecondsSinceEpoch(time);
    String formattedDate = new DateFormat("dd MMMM yyyy").format(date);

    return formattedDate;
  }

 static double getpercentage(double value){
    double percent = (value*2)/10;

    return percent;
  }

}
