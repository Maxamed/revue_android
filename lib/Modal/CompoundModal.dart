import 'package:revue_mobile/Modal/PropertyModal.dart';

class CompoundModal{
  String _compoundname;
  String _description;
  String _address;
  List _amenities = [];
  String _id;
  double _rating;
  List _images = [];
  double _facility;
  double _management;
  double _value;
  double _location;
  double _design;
  bool _isFav;
  Map<String,dynamic> _position;
  String _category;



  CompoundModal();


  String get category => _category;

  set category(String value) {
    _category = value;
  }

  Map<String, dynamic> get position => _position;

  set position(Map<String, dynamic> value) {
    _position = value;
  }

  bool get isFav => _isFav;

  set isFav(bool value) {
    _isFav = value;
  }



  Map<String,dynamic> toJson()=>{
    "compoundname":_compoundname,
    "description" :_description,
    "address":_address,
    "amenities" :_amenities,
    "id":_id,
    "rating":_rating,
    "images" :_images,
    "facility":_facility,
    "management":_management,
    "value":_value,
    "location":_location,
    "design":_design,
    "category": _category
  };


  CompoundModal.fromJson(Map<String,dynamic> json)
  : _id = json["_id"],
    _address = json["address"],
   _description = json["description"],
  _amenities = json["amenities"],
  _compoundname = json["compoundname"],
  _rating = json["rating"],
  _images = json["images"],
  _value = json["value"],
  _location = json["location"],
  _management = json["management"],
  _facility = json["facility"],
  _design = json["design"],
  _position ={"coordinates":json["position"]["coordinates"],"type":json["position"]["type"]},
  _category = json["category"];



  double get design => _design;

  set design(double value) {
    _design = value;
  }

  double get facility => _facility;

  set facility(double value) {
    _facility = value;
  }

  List get images => _images;

  set images(List value) {
    _images = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  List get amenities => _amenities;

  set amenities(List value) {
    _amenities = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get compoundname => _compoundname;

  set compoundname(String value) {
    _compoundname = value;
  }

  double get rating => _rating;

  set rating(double value) {
    _rating = value;
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
}

