import 'package:flutter/material.dart';
import '../constants.dart';

class ErrorWidget extends StatelessWidget {
  final String message;
  const ErrorWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /*margin: EdgeInsets.symmetric(
        horizontal: defaultPadding,
      ),*/
      padding: EdgeInsets.all(defaultPadding / 4),
      decoration: BoxDecoration(
        color: primaryColor,
        /*borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultRadius),
            topRight: Radius.circular(defaultRadius)),*/
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.white70),
          SizedBox(width: 10),
          Text(
            message,
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
