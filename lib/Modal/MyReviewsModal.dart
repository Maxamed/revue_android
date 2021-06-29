class MyReviewsModal{
  String _id;
  String _review;
  String _floorplan;
  String _price;
  double _rating;
  String _reviewerName;
  List _pros = [];
  List _cons = [];
  int _bathRooms;
  int _bedRooms;
  String _compoundID;
  List _images = [];
  String _userID;
  double _facilities;
  double _design;
  double _location;
  double _value;
  double _management;
  int  _reviewDate;
  String _compoundName;


  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get review => _review;

  String get compoundName => _compoundName;

  set compoundName(String value) {
    _compoundName = value;
  }


  int get reviewDate => _reviewDate;

  set reviewDate(int value) {
    _reviewDate = value;
  }

  double get management => _management;

  set management(double value) {
    _management = value;
  }

  double get value => _value;

  set value(double value) {
    _value = value;
  }

  double get location => _location;

  set location(double value) {
    _location = value;
  }

  double get design => _design;

  set design(double value) {
    _design = value;
  }

  double get facilities => _facilities;

  set facilities(double value) {
    _facilities = value;
  }

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }

  List get images => _images;

  set images(List value) {
    _images = value;
  }

  String get compoundID => _compoundID;

  set compoundID(String value) {
    _compoundID = value;
  }

  int get bedRooms => _bedRooms;

  set bedRooms(int value) {
    _bedRooms = value;
  }

  int get bathRooms => _bathRooms;

  set bathRooms(int value) {
    _bathRooms = value;
  }

  List get cons => _cons;

  set cons(List value) {
    _cons = value;
  }

  List get pros => _pros;

  set pros(List value) {
    _pros = value;
  }

  String get reviewerName => _reviewerName;

  set reviewerName(String value) {
    _reviewerName = value;
  }

  double get rating => _rating;

  set rating(double value) {
    _rating = value;
  }

  String get price => _price;

  set price(String value) {
    _price = value;
  }

  String get floorplan => _floorplan;

  set floorplan(String value) {
    _floorplan = value;
  }

  set review(String value) {
    _review = value;
  }


  MyReviewsModal.fromJson(Map<String,dynamic> jsonMap)
      : _id= jsonMap["_id"],
        _floorplan = jsonMap["floorplan"],
        _review = jsonMap["review"],
        _price = jsonMap["price"],
        _reviewerName = jsonMap["reviewerName"],
        _pros = jsonMap["pros"],
        _cons = jsonMap["cons"],
        _bathRooms = jsonMap["bathRooms"],
        _bedRooms = jsonMap["bedRooms"],
        _userID = jsonMap["userID"],
        _facilities = jsonMap["facility"],
        _design = jsonMap["design"],
        _location = jsonMap["location"],
        _value = jsonMap["value"],
        _management = jsonMap["management"],
        _rating = jsonMap["rating"],
        _reviewDate = jsonMap["timestamp"],
        _images = jsonMap["images"],
        _compoundName = jsonMap["compoundName"];
}