
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:revue_mobile/FilterScreen.dart';
import 'package:revue_mobile/Login.dart';
import 'package:revue_mobile/MainScreen.dart';
import 'package:revue_mobile/Modal/AnswerModal.dart';
import 'package:revue_mobile/Modal/CompoundModal.dart';
import 'package:revue_mobile/Modal/FavoriteModal.dart';
import 'package:revue_mobile/Modal/LikeUnlikeModal.dart';
import 'package:revue_mobile/Modal/MessagingModal.dart';
import 'package:revue_mobile/Modal/MyReviewsModal.dart';
import 'package:revue_mobile/Modal/QuestionModal.dart';
import 'package:revue_mobile/Modal/ReportModal.dart';
import 'package:revue_mobile/Modal/ReviewModal.dart';
import 'package:revue_mobile/Modal/SearchModal.dart';
import 'package:revue_mobile/Modal/Users.dart';
import 'package:http/http.dart' as http;
import 'package:revue_mobile/Service/ServerDetails.dart';
import 'package:revue_mobile/bottom_tab_bar/FavouriteCom.dart';
import 'package:revue_mobile/bottom_tab_bar/home/CompoundList.dart';
import 'package:revue_mobile/compound/SearchCompound.dart';
import 'package:revue_mobile/constant/Constants.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';
import 'package:revue_mobile/otp/OTPVerification.dart';
import 'package:revue_mobile/password/ChangePassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Webservice{

  static void registerRequest(BuildContext context,UserModal userModal) async{
    var request = userModal.toJson();
    print(request);
    var response = await http.post(Uri.parse(ServerDetails.register_request),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    var jsonResponse = convert.jsonDecode(response.body);

    if(jsonResponse["status"]== Constants.STATUS_SUCCESS &&
        jsonResponse["errorCode"] ==Constants.SUCCESS_REGISTER_CODE ){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Login()));
    }else if(jsonResponse["status"]== Constants.STATUS_FAIL &&
        jsonResponse["message"]==Constants.REGISTER_FAILED_ALREADY_EXIST){
      Fluttertoast.showToast(msg: "User Already Exist");
    }
  }

  static void loginRequest(BuildContext context,UserModal userModal)async{
    var request ={};
    request["email"] = userModal.email;
    request["password"] = userModal.password;
    print(request);
    var response = await http.post(Uri.parse(ServerDetails.login_request),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);


    if(jsonResponse["status"]==Constants.STATUS_SUCCESS &&
    jsonResponse["errorCode"] == Constants.SUCCESS_LOGIN_CODE){

      Fluttertoast.showToast(msg: "Successfully Login",gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT);

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("userID", jsonResponse["user"]["_id"]);
      sharedPreferences.setString("name", jsonResponse["user"]["firstname"]+" " +jsonResponse["user"]["lastname"]);
      sharedPreferences.setString("email",jsonResponse["user"]["email"]);
      sharedPreferences.setBool("isLoggedIn", true);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
    }
    else if(jsonResponse["status"] == Constants.STATUS_FAIL &&
    jsonResponse["errorCode"]==Constants.ERROR_CODE
    && jsonResponse["message"] == Constants.LOGIN_FAILED_DESCRIPTION_PASSWORD_UNMATCHED){

      Fluttertoast.showToast(msg: Constants.LOGIN_FAILED_DESCRIPTION_PASSWORD_UNMATCHED,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }

    else if(jsonResponse["status"] == Constants.STATUS_FAIL &&
        jsonResponse["errorCode"]==Constants.ERROR_CODE
        && jsonResponse["message"] ==Constants.LOGIN_FAILED_DESCRIPTION_USER_NOT_FOUND){

      Fluttertoast.showToast(msg: Constants.LOGIN_FAILED_DESCRIPTION_USER_NOT_FOUND,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }
  }


  static Future<dynamic>  getCompoundRequest(BuildContext context,List compoundList,String id)async{

    var request ={};
    request["lastObjectID"]= id;
    request["category"] = filterCategory;
    request["amenities"] = GlobalKeys.compoundListKey.currentState.amenityList;
    if(radius>0 && radius<30 && currentPosition!=null)
      {
        request["radius"]=radius;
        request["coordinates"]=[currentPosition.latitude,currentPosition.longitude];
      }

    // print(convert.jsonEncode(request));
    var response = await http.post(Uri.parse(ServerDetails.get_compound_request),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    // compoundList.clear();
    // print(response.body);
   var jsonResponse = convert.jsonDecode(response.body);
    // print(jsonResponse);
    CompoundModal compoundModal;
    if(jsonResponse["status"]==Constants.STATUS_SUCCESS &&
        jsonResponse["fetchCode"]==Constants.SUCCESS_FETCH_COMPOUNDLIST){
      List cList = jsonResponse["compoundList"];
      cList.forEach((element) {
        compoundModal = new CompoundModal.fromJson(element);
        compoundList.add(compoundModal);
      });
    }else if(jsonResponse["status"]==Constants.STATUS_FAIL &&
        jsonResponse["fetchCode"]==Constants.FAILED_FETCH_COMPOUNDLIST){
      // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Unable to Fetch Compound")));
    }
  }


  static Future<CompoundModal> getCompoundDetails(String id)async{
    var request ={};
    request["id"] = id;
    var response = await http.post(Uri.parse(ServerDetails.get_compound_detail_request),
        body:convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });
    var jsonResponse  = convert.jsonDecode(response.body);
    CompoundModal compoundModal;
    // print(jsonResponse);
    if(jsonResponse["status"] == Constants.STATUS_SUCCESS
        &&jsonResponse["errorCode"] == Constants.SUCCESS_CODE){
    compoundModal = CompoundModal.fromJson(jsonResponse["compoundModal"]);

    }return compoundModal;

  }

  static Future<dynamic> fetchAllReviews(BuildContext context,String id,List rList)async{
    var request ={};
    request["compoundID"] = id;
    var response = await http.post(Uri.parse(ServerDetails.get_AllReviews),
        body:convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    rList.clear();
    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["status"] == Constants.STATUS_SUCCESS){
      // print(jsonResponse);
      List list = jsonResponse["reviewList"];
      ReviewModal reviewModal;
      list.forEach((element) {
        reviewModal = new ReviewModal.fromJson(element);
        rList.add(reviewModal);

      });

    }


  }


  static Future<dynamic> addReviewRequest(BuildContext context,ReviewModal reviewModal)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var  request = new http.MultipartRequest("POST",
        Uri.parse(ServerDetails.add_Review),);
    // Map<String,String> headerMap ={"content-type":"multipart/form-data"};
    // // request.headers['content-type '] = 'multipart/form-data';
    //
    // request.headers.addAll(headerMap);

    request.fields["review"] = reviewModal.review;
    request.fields["rent"] =reviewModal.price;
    request.fields["floorplan"] = reviewModal.floorplan;
    request.fields["reviewername"] = sharedPreferences.getString("name");
    request.fields["compoundID"] = reviewModal.compoundID ;
    request.fields["userId"] = sharedPreferences.getString("userID");
    request.fields["cons"] = reviewModal.cons.toString();
    request.fields["pros"] = reviewModal.pros.toString();
    request.fields["facility"] = reviewModal.facilities.toString();
    request.fields["management"] = reviewModal.management.toString();
    request.fields["value"] = reviewModal.value.toString();
    request.fields["location"] = reviewModal.location.toString();
    request.fields["design"] = reviewModal.design.toString();
    request.fields["rating"] = reviewModal.rating.toString();
    request.fields["compoundName"] = reviewModal.compoundName;
    request.fields["timestamp"] = reviewModal.reviewDate.toString();



    List<http.MultipartFile> newList = new List<http.MultipartFile>();
    newList = reviewModal.multipartImages;
    // print(newList.length);

    request.files.addAll(newList);

    print(request.files);
    print(request.fields);
    GlobalKeys.addReviewKey.currentState.setState(() {
      GlobalKeys.addReviewKey.currentState.load=true;
    });
    var response = await request.send();

    // print(response.statusCode);

    response.stream.transform(utf8.decoder).listen((value) {
      print("response------------------ "+response.toString());
      print("valeue--------------"+value);
      Map map = json.decode(value);
      if(map["errorcode"] == 0 && map["status"]==true){
        Fluttertoast.showToast(msg: "Review Added");

        GlobalKeys.compoundDetailsKey.currentState.fetchReview();

      }
      else{
        Fluttertoast.showToast(msg: "Review Not Added. Please Try Again Later");
      }


    });
    GlobalKeys.addReviewKey.currentState.setState(() {
      GlobalKeys.addReviewKey.currentState.load=false;
      Navigator.pop(context);

    });



  }
  
  
  static Future<dynamic> getMyReviews(List myReviewList)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   var request = {};
   request["userID"] = sharedPreferences.getString("userID");
   var response = await http.post(Uri.parse(ServerDetails.my_Reviews),
     body: convert.jsonEncode(request),
       headers: {
         "content-type": "application/json",
         "accept": "application/json"
       }
   );

   myReviewList.clear();
   var jsonResponse = convert.jsonDecode(response.body);
   if(jsonResponse["status"] == Constants.STATUS_SUCCESS
       && jsonResponse["errorcode"] ==Constants.ERROR_CODE){
     MyReviewsModal reviewModal;
     List list = jsonResponse["reviewList"];
     list.forEach((element) {
       reviewModal = MyReviewsModal.fromJson(element);
       myReviewList.add(reviewModal);
     });
   }
  }

  static Future<dynamic> postQuestionRequest(BuildContext context,MessagingModal messagingModal)async{
    var request = messagingModal.toJson();
    var response = await http.post(Uri.parse(ServerDetails.post_New_Question),
      body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["status"] == Constants.STATUS_SUCCESS && jsonResponse["statusCode"]==0){
    Fluttertoast.showToast(msg: "Question Submitted Successfully ");
      Navigator.pop(context);
    }
  }


  static Future<dynamic> postAnswerRequest(BuildContext context,AnswerModal answerModal)async{
    var request = answerModal.toJson();
    // print(request);
    var response = await http.post(Uri.parse(ServerDetails.post_Answer),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });


    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["status"] == Constants.STATUS_SUCCESS
        && jsonResponse["errorCode"]==0){
      Fluttertoast.showToast(msg: "Post answer successfully",gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);

      Navigator.pop(context);
    }
  }


  static Future<dynamic> getAllRequestedQuestions (List questionsList,String compoundID) async{
    var request ={};
    request["compoundID"] = compoundID;
    var response  = await http.post(Uri.parse(ServerDetails.get_All_Questions),
    body: convert.jsonEncode(request), headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    questionsList.clear();
    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["errorCode"]==0 && jsonResponse["status"] == true){
      List list = jsonResponse["questionsList"];
      QuestionModal questionModal;
      list.forEach((element) {
        questionModal = new QuestionModal();
        questionModal.compoundID = element["compoundID"];
        questionModal.userName = element["userName"];
        questionModal.userID = element["userID"];
        questionModal.question = element["question"];
        questionModal.id = element["_id"];
        // questionModal.timestamp = element["timestamp"];

      List list =   element["answersList"];
      AnswerModal answerModal;
      List<AnswerModal> ansList =[];
      list.forEach((ansElement) {
        answerModal = AnswerModal.fromJson(ansElement);
        ansList.add(answerModal);
      });
      questionModal.answerList = ansList;
      questionsList.add(questionModal);
      });
    }
  }

  static void reportAnswerRequest(BuildContext context,ReportModal reportModal)async{
    var request = reportModal.toJson();
    print(request);
    var response = await http.post(Uri.parse(ServerDetails.report_answer),
    body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });


    var jsonResponse = convert.jsonDecode(response.body);
    // print(jsonResponse);
    if(jsonResponse["status"]==Constants.STATUS_SUCCESS &&
    jsonResponse["errorcode"] == Constants.ERROR_CODE){
      Fluttertoast.showToast(msg: "Answer Reported Successfully",gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: "Unable to report answer",gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  static Future<dynamic> likeUnlikeRequest(BuildContext context,LikeUnlikeModal likeUnlikeModal)async{
    var request = likeUnlikeModal.toJson();
    var response = await http.post(Uri.parse(ServerDetails.update_like_dislike),
    body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["errorCode"] == Constants.ERROR_CODE
        && jsonResponse["status"]==Constants.STATUS_SUCCESS){
      Fluttertoast.showToast(msg: "updated",gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }

  }

  static Future<dynamic> getAllAnswersRequest(List ansList,String qID) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request = {};
    request["questionID"]= qID;
    request["userID"] = prefs.getString("userID");
    var response = await http.post(Uri.parse(ServerDetails.get_All_Answers),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    ansList.clear();
    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["errorCode"] == Constants.ERROR_CODE
        && jsonResponse["status"]==Constants.STATUS_SUCCESS){
      List list =   jsonResponse["answerList"];
      AnswerModal answerModal;
      list.forEach((ansElement) {
        answerModal = AnswerModal.fromJson(ansElement);
        ansList.add(answerModal);
      });
    }

  }

  static Future<dynamic> reportReviewRequest(BuildContext context,String reviewID)async{
    var request={};
    request["reviewID"] = reviewID;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    request["userID"] = sharedPreferences.getString("userID");
    request["userName"] = sharedPreferences.getString("name");
    var response = await http.post(Uri.parse(ServerDetails.report_review),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["status"] == Constants.STATUS_SUCCESS &&
    jsonResponse["errorCode"] == Constants.ERROR_CODE)
    {
      Fluttertoast.showToast(msg: "Review reported successfully"
          ,gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);

      Navigator.pop(context);
    }

  }

 static Future<dynamic> addFavoriteRequest(BuildContext context,FavoriteModal favModal)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    favModal.userID = sharedPreferences.getString("userID");
    var request = favModal.toJson();
    var response = await http.post(Uri.parse(ServerDetails.add_to_Favorite),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    // print(response.body);

    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["status"]== Constants.STATUS_SUCCESS &&
        jsonResponse["errorcode"] == Constants.ERROR_CODE)
    {
      Fluttertoast.showToast(msg: "Add to Favorite"
          ,gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);

    }else{
      Fluttertoast.showToast(msg: "Something went wrong"
          ,gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }

    getAllFavoritesCompoundRequest();

  }
  static Future<dynamic> removeFavoriteRequest(BuildContext context,FavoriteModal favoriteModal)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    favoriteModal.userID =sharedPreferences.getString("userID");
    var request = favoriteModal.toJson();


    var response = await http.post(Uri.parse(ServerDetails.remove_from_favorite),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["status"]== Constants.STATUS_SUCCESS &&
        jsonResponse["errorcode"] == Constants.SUCCESS_CODE)
    {
      Fluttertoast.showToast(msg: "Remove from Favorite"
          ,gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);

    }else{
      Fluttertoast.showToast(msg: "Something went wrong"
          ,gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }

    getAllFavoritesCompoundRequest();

  }


  static Future<dynamic>  getAllFavoritesCompoundRequest()async{

    List tempFavList =[];
    List tempFavIDList = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var request ={};
    request["userID"] = sharedPreferences.getString("userID");
    // compoundList.clear();
    var response = await http.post(
        Uri.parse
      (ServerDetails.get_favorites),
    body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    // print(request);

    tempFavList.clear();tempFavIDList.clear();
    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["status"]== Constants.STATUS_SUCCESS &&
    jsonResponse["errorcode"] == Constants.SUCCESS_CODE){
      List list = jsonResponse["compound"];
      // print(list);
      CompoundModal compoundModal;
      if(list.isNotEmpty){
        list.forEach((element) {
        compoundModal = CompoundModal.fromJson(element);
        tempFavIDList.add(compoundModal.id);
        tempFavList.add(compoundModal);
        });
      }
      favList = tempFavList;
      favouriteIDList = tempFavIDList;

      GlobalKeys.compoundListKey.currentState.setState(() {

      });


    }
  }

  static Future<dynamic> searchCompoundRequest(SearchModal searchModal)async{
    var request = searchModal.toJson();
    var response = await http.post(Uri.parse(ServerDetails.search_compound),
        body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    CompoundModal compoundModal;
    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["status"]==Constants.STATUS_SUCCESS &&
        jsonResponse["code"]==Constants.SUCCESS_FETCH_COMPOUNDLIST){
      List cList = jsonResponse["compoundList"];
      List list = [];
      cList.forEach((element) {
        compoundModal = new CompoundModal.fromJson(element);
        list.add(compoundModal);
      });
      compoundSearchList = list;

    }else if(jsonResponse["status"]==Constants.STATUS_FAIL &&
        jsonResponse["code"]==Constants.FAILED_FETCH_COMPOUNDLIST){

      // print(jsonResponse["code"]);
      // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Unable to Fetch Compound")));
    }
  }



  static void socialMediaLogin(BuildContext context,String email,String name,bool twitter)async{
    var request ={};
    if(email.isNotEmpty && email!=null ){
      request["email"]= email;
    }
    if(name.isNotEmpty && name!=null ){
      request["firstname"]= name;
    }
    request["type"] = twitter;

    var response = await http.post(Uri.parse(ServerDetails.social_media_login_request),
    body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    var jsonResponse = convert.jsonDecode(response.body);
    print(response);

    if(jsonResponse["status"]==Constants.STATUS_SUCCESS &&
        jsonResponse["errorCode"] == Constants.SUCCESS_LOGIN_CODE){

      Fluttertoast.showToast(msg: "Successfully Login",gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("userID", jsonResponse["user"]["_id"]);
      sharedPreferences.setString("name", jsonResponse["user"]["firstname"]);
      if(jsonResponse["user"]["email"]!=null){
        sharedPreferences.setString("email",jsonResponse["user"]["email"]);

      }
      sharedPreferences.setBool("isLoggedIn", true);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
    }
    else {
      Fluttertoast.showToast(msg: Constants.LOGIN_FAILED_DESCRIPTION_PASSWORD_UNMATCHED,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }

  }


  static void forgetPasswordRequest(String email,BuildContext context)async{
    var request = {};
    request["email"]= email;
    var response = await http.post(Uri.parse(ServerDetails.forget_password_request),
        body: convert.jsonEncode(request), headers: {
      "content-type": "application/json",
      "accept": "application/json"
    });

    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["status"]==Constants.STATUS_SUCCESS && jsonResponse["errorCode"]==Constants.ERROR_CODE){
      Fluttertoast.showToast(msg: "Otp is send to your Email Address");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPVerification(email)));
    }else{
      Fluttertoast.showToast(msg: "Fail to Send OTP");
    }
  }


  static void validateOtpRequest(BuildContext context,String email, String otp)async{
    var request = {};
    request["email"] =email;
    request["otp"] = otp;
    var response = await http.post(Uri.parse(ServerDetails.validate_OTP_request),
        body: convert.jsonEncode(request), headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });

    var jsonResponse = convert.jsonDecode(response.body);
    if(jsonResponse["status"]==Constants.STATUS_SUCCESS && jsonResponse["errorCode"]==Constants.ERROR_CODE){
    Fluttertoast.showToast(msg: "OTP verified successfully");
      Navigator.push(context,MaterialPageRoute(builder: (context)=>ChangePassword(email)));
    }else{
      Fluttertoast.showToast(msg: "Unable to Verify OTP, Request Again");
    }
  }


  static Future<dynamic> changePasswordRequest(BuildContext context,String newPassword,String email)async{
    var request ={};
     request["email"]=email;
    request["password"]= newPassword;
    request[""]= email;
    var response = await http.post(Uri.parse(ServerDetails.change_password),body: convert.jsonEncode(request),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        });
    var jsonResponse  = convert.jsonDecode(response.body);
    if(jsonResponse["status"]==Constants.STATUS_SUCCESS && jsonResponse["errorCode"]==Constants.ERROR_CODE){
      Fluttertoast.showToast(msg: "Password changes Successfully");
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Login()));
    }
  }



}