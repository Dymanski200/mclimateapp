import 'package:flutter/material.dart';
import 'package:mclimate/models/room.dart';
import 'package:mclimate/pages/create_device/data.dart';
import 'package:mclimate/pages/create_device/page.dart';
import 'package:mclimate/pages/room_detail/components/history_list.dart';
import 'package:mclimate/pages/room_detail/components/main_list.dart';
import 'package:mclimate/pages/room_detail/data.dart';
import 'components/devices_list.dart';
import '../../constants.dart';
import 'package:provider/provider.dart';

class RoomDetailPage extends StatelessWidget {
  final Room room;
  RoomDetailPage(this.room);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          elevation: 0,
          title: Row(
            children: [
              Text(room.name),
              Spacer(),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  context.read<CreateDeviceData>().clear();
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateDevicePage(room.id),
                          ))
                      .then((value) => context
                          .read<DevicesData>()
                          .refresh(context, room.id));
                },
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Главная",
              ),
              Tab(
                text: "История",
              ),
              Tab(
                text: "Устройства",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Container(
                child: MainList(room.id),
              ),
            ),
            HistoryList(room.id),
            DevicesList(room.id),
          ],
        ),
      ),
    );
  }
}
