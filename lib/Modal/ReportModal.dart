class ReportModal{

  String _userID;
  String _userName;
  String _answerID;

  ReportModal();

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }

  String get userName => _userName;

  String get answerID => _answerID;

  set answerID(String value) {
    _answerID = value;
  }

  set userName(String value) {
    _userName = value;
  }

  Map<String,dynamic> toJson()=>{
    "userID" :_userID,
    "userName":_userName,
    "answerID":_answerID
  };
}