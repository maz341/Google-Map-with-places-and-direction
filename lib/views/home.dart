import 'dart:async';

import 'package:fittest_assignment/views/wishlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/constants.dart';
import 'nearby_restaurants.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final tab = [NearbyRestaurants(), Wishlist()];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? Icon(
                    Icons.maps_ugc,
                    size: 30.0,
                    color: blueColor,
                  )
                : Icon(
                    Icons.maps_ugc_outlined,
                    size: 25.0,
                    color: blueColor,
                  ),
            title: new Text(
              'Nearby',
              style: TextStyle(
                color: blueColor,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? Icon(
                    Icons.shopping_basket,
                    size: 30.0,
                    color: blueColor,
                  )
                : Icon(
                    Icons.shopping_basket_outlined,
                    size: 25.0,
                    color: blueColor,
                  ),
            title: new Text(
              'Wishlist',
              style: TextStyle(
                color: blueColor,
              ),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: tab[_currentIndex],
    );
  }
}
