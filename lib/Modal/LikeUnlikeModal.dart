class LikeUnlikeModal
{
  String _userID;
  String _id;
  int _operation;


  LikeUnlikeModal();

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }

  String get id => _id;

  int get operation => _operation;

  set operation(int value) {
    _operation = value;
  }

  set id(String value) {
    _id = value;
  }

  Map<String,dynamic> toJson()=>{
    "userID" : _userID,
    "_id" :_id,
    "operation":_operation
  };
}