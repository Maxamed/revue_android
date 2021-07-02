import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:revue_mobile/Modal/AmenitiesModal.dart';
import 'package:revue_mobile/Service/Webservice.dart';
import 'package:revue_mobile/constant/ColorClass.dart';
import 'package:revue_mobile/compound/SearchCompound.dart';
import 'package:revue_mobile/constant/GlobalKeys.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FilterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilterScreenState();
  }
}


String filterCategory = "";
List<AmenitiesModal> filterAmenitiesList =[];
int radius=0;
Position currentPosition;



class FilterScreenState extends State<FilterScreen> {

 static List<AmenitiesModal> amenities = [
    AmenitiesModal(id: 1,name: "Any"),
   AmenitiesModal(id: 2,name: "Balcony"),
   AmenitiesModal(id: 3,name: "Shared Spa"),
    AmenitiesModal(id: 4,name:"Covered Parking"),
   AmenitiesModal(id: 5,name: "Security"),
   AmenitiesModal(id: 6,name: "Electricity"),
   AmenitiesModal(id: 7,name: "Build in Kitchen Appliances"),
   AmenitiesModal(id: 8,name: "Furnished"),
   AmenitiesModal(id: 9,name: "Pets Allowed")];

 final _items = amenities
     .map((building) => MultiSelectItem<AmenitiesModal>(building, building.name))
     .toList();

 static  const  List searchRadius = [
     'None',
    'This area only',
    'Near 5 KM',
    'Near 10 KM',
    'Upto 20 KM',
    'Upto 25 KM',
    'More Than 25 KM'
  ];
  // List minpriceRange = [
  //   '5 Lac',
  //   '10 Lac',
  //   '15 Lac',
  //   '20 Lac',
  //   '25 Lac',
  //   '30 Lac',
  //   '35 Lac',
  //   '40 Lac'
  // ];
  // List maxpriceRange = [
  //   '5 Lac',
  //   '10 Lac',
  //   '15 Lac',
  //   '20 Lac',
  //   '25 Lac',
  //   '30 Lac',
  //   '35 Lac',
  //   '40 Lac'
  // ];
  // List bedRooms = ['1', '2', '3', '4', '5', '6'];

  String radiusSelected;
 //  String minPrice;
 //  String maxPrice;
 //  String minSelectedRooms;
 // String maxSelectedRooms;
  List<AmenitiesModal> isSelected =[];
  List<String> categoryType =<String>['Any', 'Apartment', 'Compound'];
  bool selected = false;
  int selectedIndex=0;
  Position pos;
  @override
  void initState() {
    super.initState();
    if(filterCategory=="Apartment"){
      selectedIndex =1;
    }else if(filterCategory =="Compound"){
      selectedIndex=2;
    }else{
      selectedIndex=0;
    }

    switch (radius){
      case 0:
        radiusSelected=searchRadius[0];
            break;
      case 2:
        radiusSelected=searchRadius[1];
        break;
      case 5:
        radiusSelected=searchRadius[2];
        break;
       case 10:
        radiusSelected=searchRadius[3];
        break;
        case 20:
        radiusSelected=searchRadius[4];
        break;
        case 25:
        radiusSelected=searchRadius[5];
        break;
      case 30:
        radiusSelected=searchRadius[6];
        break;
        default:
          radiusSelected=searchRadius[0];

    }

  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: Scaffold(
        bottomNavigationBar: new Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 140,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        primary: ColorClass.redColor,
                        padding: EdgeInsets.all(10),
                      ),
                      onPressed: () async{
                        List tempList =[];
                        filterAmenitiesList=isSelected;
                        isSelected.forEach((element) {
                          tempList.add((element as AmenitiesModal).name);
                        });

                        filterCategory = categoryType[selectedIndex];
                          currentPosition=pos;
                          GlobalKeys.compoundListKey.currentState.compoundList.clear();
                          GlobalKeys.compoundListKey.currentState.objectID="";
                          GlobalKeys.compoundListKey.currentState.amenityList= tempList;
                          radius=getRadius();

                        if(getRadius()>0 && getRadius()<30)
                          {
                            await determinePosition();
                            currentPosition=pos;

                          }
                        print(currentPosition);
                        print(getRadius());
                        GlobalKeys.compoundListKey.currentState.getCompoundMethod();
                        Navigator.pop(context);
                      },

                      child: Text(
                        "Apply",
                        style: TextStyle(fontSize: 16,color: Colors.white),
                      ),

                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: Colors.white,
              leading: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    CupertinoIcons.chevron_left,
                    color: Colors.black,
                  )),

              largeTitle: Text(" Filters",
                  style: const TextStyle(
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 18.0),
                  textAlign: TextAlign.left),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Location
                          Text("Location",
                              style:  TextStyle(
                                  color: ColorClass.lightHeadingColor,
                                  fontWeight: FontWeight.w400,

                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                              textAlign: TextAlign.center),

                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchCompound()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorClass.borderColor, width: 1)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      CupertinoIcons.search,
                                      size: 20,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Building,Compound or Cities",
                                          style:  TextStyle(
                                              color:ColorClass.lightTextColor,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.left)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Container(width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Category",
                              style:  TextStyle(
                                  color: ColorClass.lightHeadingColor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                              textAlign: TextAlign.left),

                          Container(
                            height: 50,alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                            // width: MediaQuery.of(context).size.width,
                            child: ToggleSwitch(
                              minWidth:110,
                              fontSize: 14.0,
                              cornerRadius: 5,
                              borderColor: [ ColorClass.borderColor],borderWidth: 1,
                              inactiveFgColor: ColorClass.lightTextColor,
                              initialLabelIndex: selectedIndex,
                              activeBgColor: [ColorClass.blueColor],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.white,
                              changeOnTap: true,
                              labels: categoryType,totalSwitches: categoryType.length,
                              onToggle: (index) {
                                setState(() {
                                  selectedIndex = index;

                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Amenities",
                              style:  TextStyle(
                                  color: ColorClass.lightHeadingColor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                              textAlign: TextAlign.center),


                          Container(
                            margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white,
                            ),
                            child: MultiSelectChipField<AmenitiesModal>(
                              headerColor: Colors.white,
                              height: 80,
                              scroll: true,
                              textStyle: TextStyle(color: ColorClass.lightTextColor,fontSize: 14),
                              showHeader: false,selectedChipColor: ColorClass.blueColor,
                              selectedTextStyle: TextStyle(color: Colors.white),
                              decoration: BoxDecoration(color: Colors.white,
                                  border: Border.all(color: Colors.black12)),
                              items: _items,
                              initialValue: filterAmenitiesList,
                              icon: Icon(Icons.check,color: Colors.white),
                              chipShape:RoundedRectangleBorder(side: BorderSide(color: ColorClass.blueColor)),
                              onTap: (values) {
                                // filterAmenitiesList =values;
                                isSelected = values;
                                },
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Search Radius",
                              style:  TextStyle(
                                  color: ColorClass.lightHeadingColor,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                              textAlign: TextAlign.center),
                          Container(
                            height: 50,
                            margin: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonHideUnderline(
                              child: GFDropdown(
                                hint: Text(
                                  "Select Search Radius",
                                  style: TextStyle(color: ColorClass.greyColor),
                                ),
                                padding: const EdgeInsets.all(15),
                                borderRadius: BorderRadius.circular(5),
                                border:  BorderSide(
                                    color: ColorClass.borderColor, width: 1),
                                dropdownButtonColor: Colors.white,
                                value: radiusSelected,
                                style: TextStyle(color: ColorClass.lightTextColor,fontSize: 14),
                                onChanged: (newValue) async{
                              determinePosition();


                                   setState(() {
                                     radiusSelected = newValue;
                                     print(radiusSelected);

                                });
                                   },
                                items: searchRadius
                                    .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // Container(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Price Range",
                    //           style:  TextStyle(
                    //               color: ColorClass.lightHeadingColor,
                    //               fontWeight: FontWeight.w400,
                    //               fontStyle: FontStyle.normal,
                    //               fontSize: 18.0),
                    //           textAlign: TextAlign.center),
                    //       Container(
                    //         width: MediaQuery.of(context).size.width,
                    //         child: FittedBox(fit: BoxFit.fitWidth,
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Container(
                    //                 height: 50,
                    //                 margin: EdgeInsets.all(10),
                    //                 width: 160,
                    //                 child: DropdownButtonHideUnderline(
                    //                   child: GFDropdown(
                    //                     hint: Text(
                    //                       "Min Price",
                    //                       style: TextStyle(color: ColorClass.greyColor),
                    //                     ),
                    //                     padding: const EdgeInsets.all(15),
                    //                     style: TextStyle(color: ColorClass.lightTextColor,fontSize: 16),
                    //                   borderRadius: BorderRadius.circular(5),
                    //                     border:  BorderSide(
                    //                         color: ColorClass.borderColor, width: 1),
                    //                     value: minPrice,
                    //
                    //                     onChanged: (newValue) {
                    //                       setState(() {
                    //                         minPrice = newValue;
                    //                       });
                    //                     },
                    //                     items: minpriceRange
                    //                         .map((value) => DropdownMenuItem(
                    //                               value: value,
                    //                               child: Text(value),
                    //                             ))
                    //                         .toList(),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Container(
                    //                 height: 50,
                    //                 width: 160,
                    //                 margin: EdgeInsets.all(10),
                    //                 child: DropdownButtonHideUnderline(
                    //                   child: GFDropdown(
                    //                     hint: Text(
                    //                       "Max Price",
                    //                       style: TextStyle(color: ColorClass.greyColor),
                    //                     ),
                    //                     padding: const EdgeInsets.all(15),
                    //                     borderRadius: BorderRadius.circular(5),
                    //                     border:  BorderSide(
                    //                         color: ColorClass.borderColor, width: 1),
                    //                     dropdownButtonColor: Colors.white,
                    //                     value: maxPrice,
                    //                     style: TextStyle(color: ColorClass.lightTextColor,fontSize: 16),
                    //
                    //                   onChanged: (newValue) {
                    //                       setState(() {
                    //                         maxPrice = newValue;
                    //                       });
                    //                     },
                    //                     items: maxpriceRange
                    //                         .map((value) => DropdownMenuItem(
                    //                               value: value,
                    //                               child: Text(value),
                    //                             ))
                    //                         .toList(),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // Container(
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       // No. of Bedrooms
                    //       Text(
                    //         "No. of Bedrooms",
                    //         style:  TextStyle(
                    //             color:ColorClass.lightTextColor,
                    //             fontWeight: FontWeight.w400,
                    //             fontStyle: FontStyle.normal,
                    //             fontSize: 18.0),
                    //       ),
                    //       Container(
                    //         width: MediaQuery.of(context).size.width,
                    //         child: FittedBox(fit: BoxFit.fitWidth,
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Container(
                    //                 height: 50,
                    //                 margin: EdgeInsets.all(10),
                    //                 width: 160,
                    //                 child: DropdownButtonHideUnderline(
                    //                   child: GFDropdown(
                    //                     hint: Text(
                    //                       "Select Min",
                    //                       style: TextStyle(color: ColorClass.greyColor),
                    //                     ),
                    //                     padding: const EdgeInsets.all(15),
                    //                     borderRadius: BorderRadius.circular(5),
                    //                     border:  BorderSide(
                    //                         color: ColorClass.borderColor, width: 1),
                    //                     value: minSelectedRooms,
                    //                     style: TextStyle(color: ColorClass.lightTextColor,fontSize: 16),
                    //
                    //                     onChanged: (newValue) {
                    //                       setState(() {
                    //                         minSelectedRooms = newValue;
                    //                       });
                    //                     },
                    //                     items: bedRooms
                    //                         .map((value) => DropdownMenuItem(
                    //                               value: value,
                    //                               child: Text(value),
                    //                             ))
                    //                         .toList(),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Container(
                    //                 height: 50,
                    //                 width: 160,
                    //                 margin: EdgeInsets.all(10),
                    //                 child: DropdownButtonHideUnderline(
                    //                   child: GFDropdown(
                    //                     hint: Text(
                    //                       "Select Max",
                    //                       style: TextStyle(color: ColorClass.greyColor),
                    //                     ),
                    //                     padding: const EdgeInsets.all(15),
                    //                     borderRadius: BorderRadius.circular(5),
                    //                     border:  BorderSide(
                    //                         color: ColorClass.borderColor, width: 1),
                    //                     dropdownButtonColor: Colors.white,
                    //                     value: maxSelectedRooms,
                    //                     style: TextStyle(color: ColorClass.lightTextColor,fontSize: 16),
                    //
                    //                     onChanged: (newValue) {
                    //                       setState(() {
                    //                         maxSelectedRooms = newValue;
                    //                       });
                    //                     },
                    //                     items: bedRooms
                    //                         .map((value) => DropdownMenuItem(
                    //                               value: value,
                    //                               child: Text(value),
                    //                             ))
                    //                         .toList(),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

 Future<Position> determinePosition() async {
   bool serviceEnabled;
   LocationPermission permission;

   // Test if location services are enabled.
   serviceEnabled = await Geolocator.isLocationServiceEnabled();

   Position position;
   permission = await Geolocator.checkPermission();
   if (permission == LocationPermission.denied) {
     permission = await Geolocator.requestPermission();
     if (permission == LocationPermission.denied) {
       // Permissions are denied, next time you could try
       // requesting permissions again (this is also where
       // Android's shouldShowRequestPermissionRationale
       // returned true. According to Android guidelines
       // your App should show an explanatory UI now.

       Fluttertoast.showToast(msg: "Location permissions are denied",gravity: ToastGravity.BOTTOM,
           toastLength: Toast.LENGTH_SHORT);
       // print('Location permissions are denied');
       // return Future.error('Location permissions are denied');
       return position;
     }
   }

   if (permission == LocationPermission.deniedForever) {
     // Permissions are denied forever, handle appropriately.
     Fluttertoast.showToast(msg: "Location permissions are permanently denied, we cannot request permissions.",gravity: ToastGravity.BOTTOM,
         toastLength: Toast.LENGTH_SHORT);
     print(   'Location permissions are permanently denied, we cannot request permissions.');
     return position;
   }

   // When we reach here, permissions are granted and we can
   // continue accessing the position of the device.
   if (!serviceEnabled) {
     // Location services are not enabled don't continue
     // accessing the position and request users of the
     // App to enable the location services.
     await Geolocator.openLocationSettings();
     Fluttertoast.showToast(msg: "Location services are disabled.",gravity: ToastGravity.BOTTOM,
         toastLength: Toast.LENGTH_SHORT);
     print('Location services are disabled.');
     return position;
   }
  position =await Geolocator.getCurrentPosition();
   setState(() {
     pos=position;
   });
   return position;
 }


  int getRadius()
 {
   int index=searchRadius.indexOf(radiusSelected);
   switch (index){
     case 0:
       return 0;
     case 1:
       return 2;
     case 2:
       return 5;
     case 3:
       return 10;
     case 4:
       return 20;
     case 5:
       return 25;
     case 6:
       return 30;
       default :
       return 30;
   }
 }
}



