import 'package:flutter/material.dart';
import 'package:mclimate/models/room.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'package:intl/intl.dart';

class CurrentValuesCard extends StatelessWidget {
  final Room room;
  CurrentValuesCard(this.room);
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
            "Текущие показатели:",
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
          SizedBox(height: defaultPadding / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Обновление:",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "${DateFormat("dd.MM.yyyy").format(room.previousUpdate)} в ${DateFormat.Hm().format(room.previousUpdate)}",
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
