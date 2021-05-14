import 'package:flutter/material.dart';
import 'package:mclimate/constants.dart';
import 'package:provider/provider.dart';
import 'room_card.dart';
import '../data.dart';

class MyRoomsList extends StatefulWidget {
  @override
  _MyRoomsListState createState() => _MyRoomsListState();
}

class _MyRoomsListState extends State<MyRoomsList> {
  @override
  void initState() {
    super.initState();
    context.read<MyRoomsData>().refresh(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: secondaryColor,
      onRefresh: () async {
        context.read<MyRoomsData>().refresh(context);
      },
      child: Stack(
        children: [
          ListView.builder(
              itemCount: context.read<MyRoomsData>().rooms.length,
              itemBuilder: (context, i) {
                return RoomCard(room: context.read<MyRoomsData>().rooms[i]);
              }),
          if (context.watch<MyRoomsData>().isBusy)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (context.watch<MyRoomsData>().isNotFound)
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
