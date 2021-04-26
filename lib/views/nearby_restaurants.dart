import 'dart:ui' as ui;

import 'dart:typed_data';


import 'package:fittest_assignment/helper/database_helper.dart';
import 'package:fittest_assignment/model/place.dart';
import 'package:fittest_assignment/utilities/utils.dart';
import 'package:fittest_assignment/widgets/placesListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import '../constants/constants.dart';
import '../widgets/custom_appbar.dart';

class NearbyRestaurants extends StatefulWidget {
  @override
  _NearbyRestaurantsState createState() => _NearbyRestaurantsState();
}

class _NearbyRestaurantsState extends State<NearbyRestaurants> {
  List<PlaceModel> myPlaces = [];
  List<PlaceModel> wishlistData = [];
  Database db;
  final dbHelper = DatabaseHelper.instance;
  bool isLoading;


  @override
  void initState() {
    super.initState();

    isLoading= false;

    initializationDb();
    getWishlistFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    print("Nearby screen ${wishlistData.length}");

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: screenSize.height,
          child: Column(
            children: [
              CustomAppBar(name: "Nearby Restaurants"),
              isLoading ? Expanded(child: Center(child: CircularProgressIndicator())) :myPlaces.length>0 ? Expanded(
                child: ListView.builder(
                  itemCount: myPlaces.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    print("My data Length ${myPlaces.length} ${myPlaces[index].rating}");
                    return PlaceListItem(place: myPlaces[index]);
                  },
                ),
              ): Expanded(child: Center(child: Text("Nearby Restaurants list empty!")),),
            ],
          ),
        ),
      ),
    );
  }

  void setDataforMyList() {
    myPlaces.addAll(myPlacesSampleData);
  }

  void initializationDb() async{
    db = await DatabaseHelper.instance.database;
  }

  void getWishlistFromDatabase() {
    setState(() {
      isLoading=true;
    });
    _query();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('get data from db:');
    setRowsTowMyList(allRows);
    allRows.forEach((row) => print(row));
  }

  void setRowsTowMyList(List<Map<String, dynamic>> allRows) {
    List<Map<String, dynamic>> dbList = allRows;

    print("DBList length ${dbList.length}");

    try{
      dbList.forEach((myItem){
        print("Myitem DbList ${myItem.length}");

        wishlistData.add(PlaceModel.fromJson(myItem));
      });
    }finally{
      setState(() {
        setDataforMyList();
        isLoading=false;
      });
    }
  }

}
