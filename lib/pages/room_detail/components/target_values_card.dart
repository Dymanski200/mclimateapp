import 'package:flutter/material.dart';
import 'package:mclimate/models/room.dart';
import 'package:mclimate/pages/profiles/data.dart';
import 'package:mclimate/pages/profiles/page.dart';
import 'package:mclimate/pages/room_detail/data.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';

class TargetValuesCard extends StatelessWidget {
  final Room room;
  TargetValuesCard(this.room);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      margin: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      padding: EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Целевые показатели:",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: defaultPadding / 2),
          Row(
            children: [
              Icon(
                Icons.thermostat_rounded,
                color: Colors.white70,
                size: 24,
              ),
              Text(
                "${room.targetTemperature}°C",
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
                "${room.targetHumidity}%",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              context.read<ProfilesData>().currentRoomID = room.id;
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilesPage()))
                  .then((value) =>
                      context.read<RoomData>().refresh(context, room.id));
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              margin: EdgeInsets.only(top: defaultPadding / 2),
              padding: EdgeInsets.all(defaultPadding / 3),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
              ),
              child: Text(
                "Выбрать профиль",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
