import 'package:fittest_assignment/constants/constants.dart';
import 'package:fittest_assignment/helper/database_helper.dart';
import 'package:fittest_assignment/model/place.dart';
import 'package:fittest_assignment/utilities/utils.dart';
import 'package:fittest_assignment/views/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class PlaceListItem extends StatelessWidget {
  final PlaceModel place;
  final List<PlaceModel> myPlaces;

  PlaceListItem({this.place,this.myPlaces});

  Database db;

  @override
  Widget build(BuildContext context) {
    
    place!=null ? print("in Item class ${place.rating} "): print("Place in item empty");
    
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(
            listPlaces: myPlaces,
          ),
        ),
      ),
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
                    backgroundImage: NetworkImage(place.image),
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
                          SizedBox(height: 3.0),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: blueColor,
                                size: 15.0,
                              ),
                              Icon(
                                Icons.star,
                                color: blueColor,
                                size: 15.0,
                              ),
                              Icon(
                                Icons.star,
                                color: blueColor,
                                size: 15.0,
                              ),
                              Icon(
                                Icons.star,
                                color: blueColor,
                                size: 15.0,
                              ),
                              Icon(
                                Icons.star_half,
                                color: blueColor,
                                size: 15.0,
                              ),
                            ],
                          ),
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
                                onTap: () => intializeDbThenSave(context),
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
    );
  }

  intializeDbThenSave(BuildContext context) async {

    db = await DatabaseHelper.instance.database;
    savePlaceToDatabase(context, place, db);
  }

}