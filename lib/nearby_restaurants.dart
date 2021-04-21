import 'package:flutter/material.dart';

class NearbyRestaurants extends StatefulWidget {
  @override
  _NearbyRestaurantsState createState() => _NearbyRestaurantsState();
}

class _NearbyRestaurantsState extends State<NearbyRestaurants> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Center(
        child: ListView(
          children: [
            myListItem(),
            myListItem(),
            myListItem(),
            myListItem(),
          ],
        ),
      ),
    );
  }

  myListItem() {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 160.0,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey,width: 1.0)),
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
                      'https://i.pinimg.com/originals/a0/17/b4/a017b4740f1197e15461ececb7313443.jpg'),
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
                          "Starbucks",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rating",
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.black54),
                        ),
                        SizedBox(height: 3.0),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.blue,
                              size: 15.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.blue,
                              size: 15.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.blue,
                              size: 15.0,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.blue,
                              size: 15.0,
                            ),
                            Icon(
                              Icons.star_half,
                              color: Colors.blue,
                              size: 15.0,
                            ),
                          ],
                        ),
                        SizedBox(height: 3.0),
                        Text(
                          "5.1 Miles",
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.black54),
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
                            Container(
                                height: 28.0,
                                width: 28.0,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Icon(
                                  Icons.directions,
                                  color: Colors.white,
                                  size: 23.0,
                                )),
                            Icon(
                              Icons.clear,
                              size: 23.0,
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
              "4th floor, The Ruby 29 Senapati Bapat Marg, Dadar West, Mumbai, Maharashtra 400028",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            "Open Now",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
