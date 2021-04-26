import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:fittest_assignment/helper/database_helper.dart';
import 'package:fittest_assignment/model/place.dart';
import 'package:fittest_assignment/utilities/utils.dart';
import 'package:fittest_assignment/widgets/custom_appbar.dart';
import 'package:fittest_assignment/widgets/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';

class MapScreen extends StatefulWidget {
  final PlaceModel place;
  final List<PlaceModel> listPlaces;

  MapScreen({this.place, this.listPlaces, Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController _controller;

  bool isLocationServiceEnabled;
  Location _location = Location();
  bool _showGoogleMaps = false;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  LatLng _initialcameraposition = LatLng(24.8974834, 67.0775689);

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final Set<Polyline> _polyline = {};

  List<PlaceModel> myPlaces = [];
  BitmapDescriptor _markerIcon;
  int _markerIdCounter = 1;

  Database db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delayMapForMilliSeconds();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          _showGoogleMaps
              ? GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialcameraposition),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  markers: Set<Marker>.of(markers.values),
                  polylines: _polyline,
                  gestureRecognizers: Set()
                    ..add(
                      Factory<EagerGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
          CustomAppBar(name: "Nearby Restaurants"),
        ]),
      ),
    );
  }

  void _onMapCreated(GoogleMapController _cntlr) async {
    _controller = _cntlr;

    final post = await _location.getLocation();
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(post.latitude, post.longitude),
          zoom: 17,
        ),
      ),
    );
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller.setMapStyle("[]");
      print("Jani RESUME");
    }
    print("Jani asasasasas");
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  void delayMapForMilliSeconds() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showGoogleMaps = true;
      });
    });
    createMarker(widget.listPlaces);
  }

  createMarker(List<PlaceModel> listPlaces) async {
    if (listPlaces != null && listPlaces.length > 0) {
      for (int x = 0; x < listPlaces.length; x++) {
        if (listPlaces[x] != null) {
          String markerPath;
          markerPath = "assets/images/marker_icon_full.png";

          final Uint8List markerIcon = await getBytesFromAsset(markerPath, 100);

          _markerIcon = BitmapDescriptor.fromBytes(markerIcon);

          final String markerIdVal = '${listPlaces[x].title}';
          // final String markerIdVal = 'marker_id_$_markerIdCounter';
          _markerIdCounter++;
          final MarkerId markerId = MarkerId(_markerIdCounter.toString());

          double lat, long;
          lat = listPlaces[x].lat;
          long = listPlaces[x].long;

          // creating a new MARKER
          final Marker marker = Marker(
            markerId: markerId,
            position: LatLng(lat, long),
            icon: _markerIcon,
            onTap: () {
              // _onMarkerTapped(markerId);
              animateToLocation(lat, long);

              showGeneralDialog(
                context: context,
                pageBuilder: (
                  dialogContext,
                  animation,
                  secondaryAnimation,
                ) =>
                    myDialogDeletedialogContext(dialogContext, animation,
                        secondaryAnimation, listPlaces[x]),
                transitionBuilder: (context, anim1, anim2, child) {
                  return SlideTransition(
                    position: Tween(
                      begin: Offset(0, 1),
                      end: Offset(0, 0),
                    ).animate(anim1),
                    child: child,
                  );
                },
                transitionDuration: Duration(milliseconds: 500),
              );
            },
          );

          print("my Marker $marker");

          setState(() {
            markers[markerId] = marker;
            print(
                "SET STate                 _____________________________________          markers[markerId] = marker;");
          });
        }
        // else showToast("Zones cordinates empty",context);
      }
    } else
      showToast("Zones empty", context);
    setState(() {
      print(
          "SET STate                 _____________________________________          One Time");
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  void animateToLocation(double lat, double long) {
    if (_controller != null) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, long),
            zoom: 19,
          ),
        ),
      );
    } else
      showToast("Map is not working properly", context);
  }

  myDialogDeletedialogContext(dialogContext, Animation<double> animation,
      Animation<double> secondaryAnimation, PlaceModel place) {
    final screenSize = MediaQuery.of(dialogContext).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: 160.0,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        place.image,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 310.0,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.title,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Rating",
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                            createDynamicRating(place),
                            SizedBox(height: 3.0),
                            Text(
                              "${place.distance} Miles",
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 65.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  splashColor: Colors.white,
                                  onTap: () => getDirection(context),
                                  child: Container(
                                    height: 28.0,
                                    width: 28.0,
                                    decoration: BoxDecoration(
                                        color: blueColor,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Icon(
                                      Icons.directions,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Colors.white,
                                  onTap: () => savePlaceToDatabase(context, place, db),
                                  child: Icon(
                                    Icons.work_outline_outlined,
                                    color: blueColor,
                                    size: 18.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: 300.0,
                child: Text(
                  place.description,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                "Open Now",
                style: TextStyle(
                  color: blueColor,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  createDynamicRating(PlaceModel place) {
    int stars = place.rating.round()-1;
    return Container(
      width: 100.0,
      height: 20.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: stars,
        itemBuilder: (context, index) {
          print('$stars $index');
          return stars == index ? Icon(
            Icons.star_half,
            color: blueColor,
            size: 15.0,
          ): Icon(
            Icons.star,
            color: blueColor,
            size: 15.0,
          );
        },
      ),
    );
}
  intializeDbThenSave(BuildContext context) async {
    db = await DatabaseHelper.instance.database;
    savePlaceToDatabase(context, widget.place, db);
  }
}