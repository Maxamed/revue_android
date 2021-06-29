class AnswerModal{
  String _compoundID;
  String _userID;
  String _userName;
  String _answer;
  int _timestamp;
  String _id;
  String _questionID;
  int _like;
  int _dislike;
  bool _isLiked;
  bool _isDisLiked;


  bool get isDisLiked => _isDisLiked;

  set isDisLiked(bool value) {
    _isDisLiked = value;
  }

  bool get isLiked => _isLiked;

  set isLiked(bool value) {
    _isLiked = value;
  }

  int get like => _like;

  set like(int value) {
    _like = value;
  }


  String get questionID => _questionID;

  set questionID(String value) {
    _questionID = value;
  }

  AnswerModal();

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get compoundID => _compoundID;

  set compoundID(String value) {
    _compoundID = value;
  }

  String get userID => _userID;

  int get timestamp => _timestamp;

  set timestamp(int value) {
    _timestamp = value;
  }

  String get answer => _answer;

  set answer(String value) {
    _answer = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  set userID(String value) {
    _userID = value;
  }


  Map<String,dynamic> toJson()=>{
    "userID":_userID,
    "compoundID":_compoundID,
    "userName":_userName,
    "answer":_answer,
    "timestamp" :_timestamp,
    "questionID" :_questionID
  };



  AnswerModal.fromJson(Map<String,dynamic> jsonMap)
  : _userID = jsonMap["userID"],
  _answer = jsonMap["answer"],
  _timestamp = jsonMap["timestamp"],
  _userName = jsonMap["userName"],
  _compoundID = jsonMap["compoundID"],
  _questionID = jsonMap["questionID"],
  _like = jsonMap["like"],
  _dislike = jsonMap["dislike"],
  _id = jsonMap["_id"],
  _isLiked = jsonMap["liked"],
  _isDisLiked = jsonMap["disliked"];

  int get dislike => _dislike;

  set dislike(int value) {
    _dislike = value;
  }
}