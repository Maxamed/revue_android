 class ServerDetails{
  static String base_url ="http://94.237.48.11:9090";

  // static String base_url= "http://192.168.1.125:8080/Revue_Backend-1.0-SNAPSHOT";
 static String register_request = base_url+"/register";
 static String login_request = base_url+"/login";
 static String get_compound_request = base_url+"/getCompound";
  static String get_compound_detail_request = base_url+"/getCompoundDetails/";
  static String get_AllReviews = base_url+"/getReviews";
  static String add_Review= base_url+"/addReview";
  static String post_New_Question = base_url+"/postQuestion";
  static String get_images = base_url+"/image/";
  static String my_Reviews = base_url+"/myReviews";
  static String post_Answer = base_url+"/postAnswer";
  static String get_All_Questions = base_url+"/fetchQuestions";
  static String update_like_dislike = base_url+"/likeDislike";
  static String report_answer = base_url+"/reportAnswer";
  static String get_All_Answers = base_url+"/getAllAnswers";
  static String report_review = base_url+"/reportReview";
  static String add_to_Favorite = base_url+"/addFavoriteCompound";
  static String remove_from_favorite = base_url+"/removeFavoriteCompound";
  static String get_favorites = base_url+"/getFavorites";
  static String search_compound = base_url+"/searchCompound";
  static String social_media_login_request  = base_url+"/socialSignIn";
  static String forget_password_request = base_url+"/sendOtp";
  static String validate_OTP_request = base_url+"/verifyOtp";
  static String change_password = base_url+"/updatePassword";
  static String check_review = base_url+"/checkReview";
}