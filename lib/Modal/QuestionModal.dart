import 'package:revue_mobile/Modal/AnswerModal.dart';

class QuestionModal{

  String _userID;
  String _compoundID;
  String _question;
  String _userName;
  int _timestamp;
  String _id;
  List <AnswerModal> _answerList;


  List<AnswerModal> get answerList => _answerList;

  set answerList(List<AnswerModal> value) {
    _answerList = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  QuestionModal();


  int get timestamp => _timestamp;

  set timestamp(int value) {
    _timestamp = value;
  }

  String get userID => _userID;

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get question => _question;

  set question(String value) {
    _question = value;
  }

  String get compoundID => _compoundID;

  set compoundID(String value) {
    _compoundID = value;
  }

  set userID(String value) {
    _userID = value;
  }

  Map<String,dynamic> toJson()=>{
    "userID":_userID,
    "compoundID":_compoundID,
    "userName":_userName,
    "question":_question,
    "timestamp" :_timestamp
  };

  QuestionModal.fromJson(Map<String,dynamic> jsonmap)
    : _question = jsonmap["question"],
  _id = jsonmap["_id"],
  _compoundID = jsonmap["compoundID"],
  _userID = jsonmap["userID"],
  _userName = jsonmap["userName"],
  _timestamp = jsonmap["timestamp"],

  _answerList = jsonmap["answersList"];


}