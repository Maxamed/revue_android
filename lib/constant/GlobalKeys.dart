import 'package:flutter/material.dart';
import 'package:revue_mobile/add_review/AddReviewBottomSheetSecond.dart';
import 'package:revue_mobile/bottom_tab_bar/FavouriteCom.dart';
import 'package:revue_mobile/bottom_tab_bar/home/CompoundList.dart';
import 'package:revue_mobile/compound/CompoundDetails.dart';

class GlobalKeys{
 static final addReviewSecondKey =  GlobalKey<AddReviewBottomSheetSecondState>();
 static final favoriteKey = GlobalKey<FavouriteComState>();
 static final compoundListKey =new  GlobalKey<CompoundListState>();
 static final compoundDetailsKey = new GlobalKey<CompoundDetailsState>();
}