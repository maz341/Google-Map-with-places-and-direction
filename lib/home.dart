import 'dart:async';

import 'package:fittest_assignment/nearby_restaurants.dart';
import 'package:fittest_assignment/wishlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);


  int _currentIndex = 0;

  final tab = [
    NearbyRestaurants(),
    Wishlist()
  ];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          // this will be set when a new tab is tapped
          items: [
            // BottomNavigationBarItem(
            //   icon: _currentIndex == 0
            //       ? new Image.asset('assets/images/home_icon_active.png',
            //       height: 30.0)
            //       : new Image.asset(
            //     'assets/images/home_icon.png',
            //     height: 25.0,
            //   ),
            //   title: new Text('Nearby'),
            // ),
            // BottomNavigationBarItem(
            //   icon: _currentIndex == 1
            //       ? new Image.asset('assets/images/dumbell_icon_active.png',
            //       height: 30.0)
            //       : new Image.asset('assets/images/dumbell_icon.png',
            //       height: 25.0),
            //   title: new Text('Wishlist'),
            // ),
            BottomNavigationBarItem(
              icon: _currentIndex == 0
                  ? new Image.asset('assets/images/home_icon_active.png',
                  height: 30.0)
                  : new Image.asset(
                'assets/images/home_icon.png',
                height: 25.0,
              ),
              title: new Text('Nearby'),
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 1
                  ? new Image.asset('assets/images/dumbell_icon_active.png',
                  height: 30.0)
                  : new Image.asset('assets/images/dumbell_icon.png',
                  height: 25.0),
              title: new Text('Wishlist'),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      appBar: AppBar(title: Text("Nearby Restaurants"),),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
          ),
          Container(
            child: Text("Hello", style: TextStyle(fontSize: 60.0, color:Colors.black),)
          ),
        tab[_currentIndex],
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }


}