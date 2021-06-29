class MessagingModal {
  String _compoundID;
  String _compoundName;
  String _question;
  String _userID;
  String _userName;
  int _timestamp;


  int get timestamp => _timestamp;

  set timestamp(int value) {
    _timestamp = value;
  }

  MessagingModal();

  String get compoundID => _compoundID;

  set compoundID(String value) {
    _compoundID = value;
  }

  String get compoundName => _compoundName;

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }

  String get question => _question;

  set question(String value) {
    _question = value;
  }

  set compoundName(String value) {
    _compoundName = value;
  }



  Map<String,dynamic> toJson()=>{
    "compoundID" :_compoundID,
    "userID":_userID,
    "userName":_userName,
    "question":_question,
    "compoundName":_compoundName,
    "timestamp":_timestamp
  };


  MessagingModal.fromJson(Map<String, dynamic> json)
      : _compoundName= json["compoundName"],
  _compoundID = json["_compoundID"],
  _userName = json["userName"],
  _question = json["question"],
  _userID = json["compoundName"],
  _timestamp = json["timestamp"];

}