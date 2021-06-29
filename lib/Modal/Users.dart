class UserModal{
  String _email;
  String _password;
  String _firstName;
  String _lastName;
  String _mobileNumber;
  String _uID;

  UserModal();
  String get uID => _uID;

  set uID(String value) {
    _uID = value;
  }




  String get email => _email;

  set email(String value) {
    _email = value;
  }

  Map<String,dynamic> toJson()=>{
    "email" :_email,
    "password" : _password,
    "firstname" : _firstName,
    "lastname" : _lastName,
    "mobilenumber" :_mobileNumber
  };

  UserModal.fromJson(Map <String,dynamic> jsonMap)
      : _email = jsonMap["email"],
  _firstName = jsonMap["firstname"],
  _lastName = jsonMap["lastname"],
  _password = jsonMap["password"],
  _mobileNumber = jsonMap["mobilenumber"];

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get mobileNumber => _mobileNumber;

  set mobileNumber(String value) {
    _mobileNumber = value;
  }
}