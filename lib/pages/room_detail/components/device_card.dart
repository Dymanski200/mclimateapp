import 'package:flutter/material.dart';
import 'package:mclimate/pages/room_detail/data.dart';
import 'package:mclimate/pages/rules/page.dart';
import '../../../models/device.dart';
import '../../../constants.dart';
import 'package:provider/provider.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    Key key,
    @required this.device,
  }) : super(key: key);

  final Device device;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RulesPage(device.id)));
      },
      onLongPress: () {
        context.read<DevicesData>().delete(context, device.roomID, device.id);
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
            Icon(
              Icons.developer_mode_rounded,
              color: Colors.blueAccent,
              size: 100,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  Text(
                    "Статус: ${device.status}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
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
