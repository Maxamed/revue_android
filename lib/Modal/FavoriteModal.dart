class FavoriteModal{
  String _userID;
  String _compoundID;


  FavoriteModal();

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }

  String get compoundID => _compoundID;

  set compoundID(String value) {
    _compoundID = value;
  }


  Map<String,dynamic>  toJson()=>{
    "userID" : _userID,
    "compoundID" :_compoundID
  };
}