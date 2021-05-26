import 'package:flutter/material.dart';

import '../../../constants.dart';

class MenuItem extends StatelessWidget {
  String name;
  IconData icon;
  Function onTap;

  MenuItem({@required this.name, @required this.icon, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        margin: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        padding: EdgeInsets.only(
          top: defaultPadding / 4,
          bottom: defaultPadding / 4,
          left: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Icon(icon, color: Colors.blueAccent, size: 100),
          ],
        ),
      ),
    );
  }
}
