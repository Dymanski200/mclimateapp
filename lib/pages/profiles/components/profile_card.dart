import 'package:flutter/material.dart';
import 'package:mclimate/models/profile.dart';
import 'package:mclimate/pages/profiles/data.dart';
import '../data.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;

  ProfileCard(this.profile);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        context.read<ProfilesData>().delete(profile.id);
      },
      onTap: () {
        context.read<ProfilesData>().setClimate(profile);
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
            Icon(Icons.settings_applications_rounded,
                color: Colors.blueAccent, size: 100),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      profile.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
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
                        "${profile.targetTemperature}°C",
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
                        "${profile.targetHumidity}%",
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
            ),
          ],
        ),
      ),
    );
  }
}
