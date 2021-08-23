import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rooj/screens/confirmBooking/confirBooking.dart';
import 'package:rooj/style/colors.dart';
import 'package:rooj/style/sizes.dart';

class ViewLocation extends StatefulWidget {
  @override
  _ViewLocationState createState() => _ViewLocationState();
}

class _ViewLocationState extends State<ViewLocation> {
  Completer<GoogleMapController> _controller = Completer();
  // GoogleMapController? myController;
  late double currentLat;
  late double currentLong;
  String searchAddress = "ابحث بالموقع";
  Marker marker = Marker(
    markerId: MarkerId("1"),
  );
  // BitmapDescriptor? pinLocationIcon;

  // var location = Location();

  // bool? _serviceEnabled;
  // PermissionStatus? _permissionGranted;
  // LocationData? _locationData;
  // Future _getCurrentLocation() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled!) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled!) {
  //       return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   _locationData = await location.getLocation();
  //   final coordinates =
  //       new Coordinates(_locationData!.latitude, _locationData!.longitude);
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   var first = addresses.first;
  //   print(
  //       'locationsss: ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
  //   setState(() {
  //     currentLat = _locationData!.latitude!;
  //     currentLong = _locationData!.longitude!;
  //     currentAddress = first.addressLine;
  //   });
  //   setState(() {
  //     _loader = false;
  //   });
  // }

  void initState() {
    location();
    super.initState();
    // _getCurrentLocation();
  }

  Position? updatedPosition;
  // String address = "";
  // getLocationAddress(position, lat, lng) async {
  //   LatLng loc = position;
  //   setState(() {
  //     currentLat = loc.latitude;
  //     currentLong = loc.longitude;
  //   });
  //   final coordinates = new Coordinates(currentLat, currentLong);
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   var first = addresses.first;
  //   // print(
  //   //     'locationsss: ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
  //   print('locationsss: ${first.thoroughfare}');
  //   setState(() {
  //     currentAddress = first.addressLine;
  //   });
  // }

  bool loader = true;

  Future location() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    currentLat = _locationData.latitude!;
    currentLong = _locationData.longitude!;
    setState(() {
      loader = false;
    });
    print('$_locationData _locationData');
  }

  Future<void> moveCamera() async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLat, currentLong),
      zoom: 12.0,
    )));
  }

  List searchList = [];

  @override
  Widget build(BuildContext context) {
    print('object');
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('موقعك'),
      // ),
      body: loader
          ? Container(
              height: height(context),
              width: width(context),
              child: Center(
                child: SpinKitHourGlass(
                  color: AppColors.mainColor,
                  size: 25,
                ),
              ))
          : SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GoogleMap(
                              mapType: MapType.terrain,
                              onCameraIdle: () {
                                print(updatedPosition);
                              },
                              initialCameraPosition: CameraPosition(
                                target: LatLng(currentLat, currentLong),
                                zoom: 12.0,
                              ),
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              onTap: (location) {
                                currentLat = location.latitude;
                                currentLong = location.longitude;
                                // getLocationAddress(
                                //     location, location.latitude, location.longitude);

                                setState(() {});
                              },
                              onCameraMove: (loc) {
                                _updatePosition(loc);
                              },
                              markers: Set<Marker>.of(<Marker>[
                                Marker(
                                  draggable: true,
                                  markerId: MarkerId("1"),
                                  position: LatLng(currentLat, currentLong),
                                  icon: BitmapDescriptor.defaultMarker,
                                )
                              ])),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(15),
                    //   child: Align(
                    //     alignment: Alignment.topLeft,
                    //     child: InkWell(
                    //       onTap: () {
                    //         Get.back();
                    //       },
                    //       child: Icon(
                    //         Icons.check_circle,
                    //         color: AppColors.mainColor,
                    //         size: 32,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.mainColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15, vertical: height(context) * 0.3),
                      child: InkWell(
                        onTap: () {
                          location().then((value) => moveCamera());
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.my_location_rounded,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  _updatePosition(CameraPosition _position) async {
    Position newMarkerPosition = Position(
        latitude: _position.target.latitude,
        longitude: _position.target.longitude,
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        timestamp: DateTime.now());
    setState(() {
      updatedPosition = newMarkerPosition;
      marker = marker.copyWith(
          positionParam:
              LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
    });
  }
}
