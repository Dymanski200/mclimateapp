import 'package:flutter/material.dart';
import 'package:mclimate/pages/room_detail/page.dart';
import 'package:mclimate/pages/rooms/data.dart';
import '../../../models/room.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({
    Key key,
    @required this.room,
  }) : super(key: key);

  final Room room;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        context.read<RoomsData>().delete(context, room.id);
      },
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RoomDetailPage(room)));
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        margin: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        padding: EdgeInsets.all(defaultPadding / 4),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.sensor_door_rounded,
                color: Colors.blueAccent, size: 100),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      room.name,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: defaultPadding),
                Row(
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
          ],
        ),
      ),
    );
  }
}
