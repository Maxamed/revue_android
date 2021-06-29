class SearchModal{
  String _string;


  SearchModal();

  String get string => _string;

  set string(String value) {
    _string = value;
  }

  Map<String,dynamic> toJson()=>
      {
        "string":_string
      };
}