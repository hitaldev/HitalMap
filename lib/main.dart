import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import "package:latlong2/latlong.dart" ;
class LocationModel {
  String ? name;
  String ? image;
  LatLng ? latLng;
  LocationModel({this.name, this.image, this.latLng});
}
void main() {
  runApp(HitalDev());
}
class HitalDev extends StatefulWidget {
  const HitalDev({Key? key}) : super(key: key);
  @override
  _HitalDevState createState() => _HitalDevState();
}
class _HitalDevState extends State<HitalDev> {
  Marker ? markers = Marker(
      point: LatLng(35.7448416,51.3731325),   builder: (context) {
         return Image.asset("assets/images/location.png");
    }
  );
  MapController mapController = MapController();
  LocationData ? locationData ;
  List<LocationModel> listLocation = [
    LocationModel(
        name: "برج میلاد",
        image: "assets/images/map1.png",
        latLng: LatLng(35.7448416,51.3731325)
    ),
    LocationModel(
        name: "حرم امام رضا (ع)",
        image: "assets/images/map2.png",
        latLng: LatLng(36.2887761,59.617813)
    ),
    LocationModel(
        name: "سی و سه پل",
        image: "assets/images/map3.png",
        latLng: LatLng(32.644856,51.6669818)
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Theme(
        data: ThemeData(
            fontFamily: "YekanBakh"
        ),
        child: SafeArea(
          child:Scaffold(
            body: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options:  MapOptions(
                    center: locationData == null ?
                    LatLng(35.7448416,51.3731325)
                        :  LatLng(locationData!.latitude!, locationData!.longitude!),
                    zoom: 15,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                      additionalOptions: {
                        'accessToken':
                        'pk.eyJ1IjoiYWQtYmxvY2siLCJhIjoiY2todnc4b3I5MDNzcjJxbXAwOWk2bHgyNCJ9.URRGeKXocM8Q42XvrhGEBQ',
                        'id': 'mapbox/streets-v11',
                      },
                    ),
                    MarkerLayerOptions(markers: [markers!])
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(listLocation.length, (index) {
                            return  GestureDetector(
                              onTap: () {
                                setState(() {
                                  markers = Marker(
                                      point: listLocation[index].latLng!,
                                      builder: (context) {
                                        return Image.asset("assets/images/location.png");
                                      }
                                  );
                                  mapController.move(listLocation[index].latLng!, 16);
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(listLocation[index].image!,
                                      width: 70,height: 70,fit: BoxFit.fill,),
                                  ),
                                  Text(listLocation[index].name!,textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,style: TextStyle(
                                      fontWeight: FontWeight.w900,fontSize: 13
                                  ),),
                                ],
                              ),
                            );
                          })
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}