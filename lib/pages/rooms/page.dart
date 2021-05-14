import 'package:flutter/material.dart';
import 'package:mclimate/pages/rooms/data.dart';
import 'components/room_card.dart';
import '../../constants.dart';
import 'components/rooms_list.dart';
import 'components/my_rooms_list.dart';
import 'package:provider/provider.dart';

class RoomsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          elevation: 0,
          title: Text("Помещения"),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Мои",
              ),
              Tab(
                text: "Все",
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            MyRoomsList(),
            RoomsList(),
          ],
        ),
      ),
    );
  }
}
