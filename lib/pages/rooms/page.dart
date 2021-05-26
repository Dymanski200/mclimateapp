import 'package:flutter/material.dart';
import 'package:mclimate/pages/create_room/data.dart';
import 'package:mclimate/pages/create_room/page.dart';
import '../../constants.dart';
import 'components/rooms_list.dart';
import 'package:provider/provider.dart';
import 'data.dart';

class RoomsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Text("Помещения"),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                context.read<CreateRoomData>().clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateRoomPage())).then(
                    (value) => context.read<RoomsData>().refresh(context));
              },
            ),
          ],
        ),
      ),
      body: RoomsList(),
    );
  }
}
