import 'package:flutter/material.dart';

showAlertDialog(BuildContext context ){
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => showCustomDialog(dialogContext));
}

showCustomDialog(BuildContext dialogContext) {
  final screenSize = MediaQuery.of(dialogContext).size;
  return AlertDialog(
    backgroundColor: Colors.transparent,
    contentPadding: EdgeInsets.all(0.0),
    content: Container(
      height: 120.0,
      width: screenSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50.0,
              width: 50.0,
              child: Center(
                child: CircularProgressIndicator(backgroundColor: Colors.grey,)
              ),
            ),
            SizedBox(height:10.0),
            Text(
              'Loading',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ],
        ),
      ),
    ),
  );
}


hideAlertDialog(BuildContext dialogContext){
  Navigator.pop(dialogContext);
}
