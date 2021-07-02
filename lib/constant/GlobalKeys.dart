import 'package:flutter/material.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetFirst.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetSecond.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetThird.dart';
import 'package:revue_mobile/add_review/Add_Review.dart';
import 'package:revue_mobile/bottom_tab_bar/FavouriteCom.dart';
import 'package:revue_mobile/bottom_tab_bar/home/CompoundList.dart';
import 'package:revue_mobile/compound/CompoundDetails.dart';
import 'package:revue_mobile/messages/MessagingScreen.dart';
import 'package:revue_mobile/messages/QuestionAnswerScreen.dart';
import 'package:revue_mobile/reviews/reviews_list.dart';

class GlobalKeys{
 static final addReviewSecondKey =  GlobalKey<AddReviewBottomSheetSecondState>();
 static final favoriteKey = GlobalKey<FavouriteComState>();
 static final compoundListKey =new  GlobalKey<CompoundListState>();
 static final compoundDetailsKey = new GlobalKey<CompoundDetailsState>();
 static final addReviewFirstKey = GlobalKey<AddReviewBottomSheetState>();
 static final addReviewThirdKey = GlobalKey<AddReviewBottomSheetThirdState>();
 static final reviewListKey = GlobalKey<ReviewListState>();
 static final addReviewKey = GlobalKey<AddReviewState>();
 static final addQuestionKey = GlobalKey<MessagingScreenState>();
 static final addAswerKey = GlobalKey<QuestionAnswerScreenState>();

}