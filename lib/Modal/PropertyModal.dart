class Property{
  List<double> _coordinates;
  String _type;


  Property();

  List<double> get coordinates => _coordinates;

  set coordinates(List<double> value) {
    _coordinates = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }


  Property.fromJson(Map<String,dynamic> jsonMap)
      : _coordinates = jsonMap["coordinates"],
        _type = jsonMap["type"];

}