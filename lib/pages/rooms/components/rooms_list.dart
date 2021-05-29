import 'package:flutter/material.dart';
import 'package:mclimate/constants.dart';
import 'package:provider/provider.dart';
import 'room_card.dart';
import '../data.dart';

class RoomsList extends StatefulWidget {
  @override
  _RoomsListState createState() => _RoomsListState();
}

class _RoomsListState extends State<RoomsList> {
  @override
  void initState() {
    super.initState();
    context.read<RoomsData>().currentContext = context;
    context.read<RoomsData>().refresh(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: secondaryColor,
      onRefresh: () async {
        context.read<RoomsData>().refresh(context);
      },
      child: Stack(
        children: [
          ListView.builder(
              itemCount: context.read<RoomsData>().rooms.length,
              itemBuilder: (context, i) {
                return RoomCard(room: context.read<RoomsData>().rooms[i]);
              }),
          if (context.watch<RoomsData>().isBusy)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (context.watch<RoomsData>().isNotFound)
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
