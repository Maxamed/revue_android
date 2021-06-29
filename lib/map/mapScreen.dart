

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:revue_mobile/constant/ColorClass.dart';

class MapPage extends StatelessWidget {

  double latiTude;
  double longiTude;
  MapPage(double latitude,double longitude)
  {
    this.latiTude=latitude;
    this.longiTude=longitude;
  }

  @override
  Widget build(BuildContext context) {
    var markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: latLng.LatLng(latiTude, longiTude),
        builder: (ctx) => Container(
          // child: FlutterLogo(
          //   textColor: Colors.blue,
          //   key: ObjectKey(Colors.blue),
          // ),
          child: Icon(
            CupertinoIcons.location_solid,color: ColorClass.redColor,key: ObjectKey(ColorClass.redColor),),
        ),
      ),
      // Marker(
      //   width: 80.0,
      //   height: 80.0,
      //   point: latLng.LatLng(53.3498, -6.2603),
      //   builder: (ctx) => Container(
      //     child: FlutterLogo(
      //       textColor: Colors.green,
      //       key: ObjectKey(Colors.green),
      //     ),
      //   ),
      // ),
      // Marker(
      //   width: 80.0,
      //   height: 80.0,
      //   point: latLng.LatLng(48.8566, 2.3522),
      //   builder: (ctx) => Container(
      //     child: FlutterLogo(
      //       textColor: Colors.purple,
      //       key: ObjectKey(Colors.purple),
      //     ),
      //   ),
      // ),
    ];

    return 
      CupertinoScaffold(
        body: Scaffold(

        appBar: AppBar(leading:
        GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.chevron_left,
              color: Colors.black,
            )),
          title: Text('Map',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,),
        // drawer: buildDrawer(context, route),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Padding(
              //   padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              //   child: Text('This is a map that is showing (51.5, -0.9).'),
              // ),
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
              bounds: LatLngBounds(latLng.LatLng(latiTude, longiTude), latLng.LatLng(latiTude, longiTude)),
            boundsOptions: FitBoundsOptions(padding: EdgeInsets.all(8.0)),
                    // center: latLng.LatLng(51.5, -0.09),
                    zoom: 5.0,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                      // For example purposes. It is recommended to use
                      // TileProvider with a caching and retry strategy, like
                      // NetworkTileProvider or CachedNetworkTileProvider
                      tileProvider: NonCachingNetworkTileProvider(),
                    ),
                    MarkerLayerOptions(markers: markers)
                  ],
                ),
              ),
            ],
          ),
        ),
    ),
      );
  }
}
