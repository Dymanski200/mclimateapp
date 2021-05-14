import 'package:flutter/material.dart';
import '../../../models/room.dart';
import '../../../constants.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    Key key,
    @required this.room,
  }) : super(key: key);

  final Room room;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      margin: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                room.name,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius:
                      BorderRadius.all(Radius.circular(defaultRadius)),
                ),
                padding: EdgeInsets.all(defaultPadding / 6),
                child: Icon(
                  Icons.room_preferences_rounded,
                  color: Colors.white70,
                  size: 24,
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.thermostat_rounded,
                color: Colors.white70,
                size: 24,
              ),
              Text(
                "${room.temperature}°C",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: defaultPadding / 2),
              Icon(
                Icons.opacity_rounded,
                color: Colors.white70,
                size: 24,
              ),
              Text(
                "${room.humidity}%",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
