import 'package:fittest_assignment/helper/database_helper.dart';
import 'package:fittest_assignment/model/place.dart';
import 'package:fittest_assignment/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

List<PlaceModel> myPlacesSampleData = [
  PlaceModel(
    place_id:1,
    image:
        'https://images.unsplash.com/photo-1552566626-52f8b828add9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    rating: 3.5,
    description:
        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print',
    title: 'Starbucks',
    distance: 3.1,
    lat: 24.900913,
    long: 67.077344,
  ),
  PlaceModel(
    place_id:2,
    image:
        'https://images.unsplash.com/photo-1552566626-52f8b828add9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    rating: 1.0,
    description:
        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print',
    title: 'Pizza Max',
    distance: 2.9,
    lat: 24.900700,
    long: 67.070804,
  ),
  PlaceModel(
    place_id:3,
    image:
        'https://images.unsplash.com/photo-1552566626-52f8b828add9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    rating: 3.5,
    description:
        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print',
    title: 'Burger Point',
    distance: 16.0,
    lat: 24.906241,
    long: 67.077395,
  ),
  PlaceModel(
    place_id: 4,
    image:
        'https://images.unsplash.com/photo-1552566626-52f8b828add9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    rating: 3.5,
    description:
        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print',
    title: 'Hot N Roll',
    distance: 3.1,
    lat: 24.896293,
    long: 67.077867,
  ),
  PlaceModel(
    place_id:5,
    image:
        'https://images.unsplash.com/photo-1552566626-52f8b828add9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmVzdGF1cmFudHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    rating: 5.0,
    description:
        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print',
    title: 'Pizza Hut',
    distance: 3.1,
    lat: 24.901427,
    long: 67.080343,
  )
];



savePlaceToDatabase(BuildContext context, PlaceModel place, Database db) async {

    Map<String, dynamic> row = {
      DatabaseHelper.columnPlaceId : place.place_id,
      DatabaseHelper.columnTitle : place.title,
      DatabaseHelper.columnDescription:  place.description,
      DatabaseHelper.columnImage : place.image,
      DatabaseHelper.columnDistance:  place.distance,
      DatabaseHelper.columnRating : place.rating,
      DatabaseHelper.columnLat:  place.lat,
      DatabaseHelper.columnLong:  place.long,
    };

    int id = await db.insert(DatabaseHelper.table, row);

    print("My Result ${await db.query(DatabaseHelper.table)}");
    showToast("Data insert!", context);
}

getDirection(BuildContext context) {
  showToast("Direction Api Requires Credit Card", context);
}
