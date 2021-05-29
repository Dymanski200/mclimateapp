import 'package:flutter/material.dart';
import 'package:mclimate/constants.dart';
import 'package:provider/provider.dart';
import 'device_card.dart';
import '../data.dart';

class DevicesList extends StatefulWidget {
  final id;
  DevicesList(int this.id);
  @override
  _DevicesListState createState() => _DevicesListState();
}

class _DevicesListState extends State<DevicesList> {
  @override
  void initState() {
    super.initState();
    context.read<DevicesData>().currentContext = context;
    context.read<DevicesData>().refresh(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: secondaryColor,
      onRefresh: () async {
        context.read<DevicesData>().refresh(context, widget.id);
      },
      child: Stack(
        children: [
          ListView.builder(
              itemCount: context.read<DevicesData>().devices.length,
              itemBuilder: (context, i) {
                return DeviceCard(
                    device: context.read<DevicesData>().devices[i]);
              }),
          if (context.watch<DevicesData>().isBusy)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (context.watch<DevicesData>().isNotFound)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: Colors.white70,
                    size: 60,
                  ),
                  Text(
                    "Не найдено",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
