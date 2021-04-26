import 'package:fittest_assignment/helper/database_helper.dart';
import 'package:fittest_assignment/model/place.dart';
import 'package:fittest_assignment/widgets/custom_appbar.dart';
import 'package:fittest_assignment/widgets/placesListItem.dart';
import 'package:flutter/material.dart';


class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  final dbHelper = DatabaseHelper.instance;
  List<PlaceModel> myPlaces = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getWishlistFromDatabase();

  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: screenSize.height,
          child: Column(
            children: [
              CustomAppBar(name: "Nearby Restaurants"),
              myPlaces.length>0 ? Expanded(
                child: ListView.builder(
                  itemCount: myPlaces.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => PlaceListItem(place: myPlaces[index], myPlaces: myPlaces,),
                ),
              ):Expanded(child: Center(child: Text("Wish list empty!"))),
            ],
          ),
        ),
      ),
    );
  }

  void getWishlistFromDatabase() {
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

    try{
      dbList.forEach((myItem){
        myPlaces.add(PlaceModel.fromJson(myItem));
      });
    }finally{
      setState(() {

      });
    }
  }

}
