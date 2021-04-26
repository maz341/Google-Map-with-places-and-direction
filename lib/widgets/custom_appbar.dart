import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
        color: Colors.white,
      ),
      width: screenSize.width,
      height: 70.0,
      child: Column(
        children: [
          SizedBox(height:10.0),
          Text(
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              // color:Colors.red,
              width: 100.0,
              padding: EdgeInsets.only(right: 30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.clear_all_outlined,
                    size: 22.0,
                    color: blueColor,
                  ),
                  SizedBox(width: 5.0,),
                  Icon(
                    Icons.circle_notifications,
                    size: 22.0,
                    color: blueColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

