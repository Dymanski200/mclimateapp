import 'package:flutter/material.dart';
import 'package:mclimate/constants.dart';
import 'package:mclimate/models/room.dart';
import 'package:mclimate/pages/room_detail/components/current_values_card.dart';
import 'package:mclimate/pages/room_detail/components/history_list.dart';
import 'package:mclimate/pages/room_detail/components/target_values_card.dart';
import '../data.dart';
import 'package:provider/provider.dart';

class MainList extends StatefulWidget {
  final int id;
  MainList(this.id);

  @override
  _MainListState createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  @override
  void initState() {
    super.initState();
    context.read<RoomData>().refresh(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!context.watch<RoomData>().isBusy)
          SingleChildScrollView(
            child: Column(
              children: [
                if (context.watch<RoomData>().room != null)
                  CurrentValuesCard(context.watch<RoomData>().room),
                if (context.watch<RoomData>().room != null)
                  TargetValuesCard(context.watch<RoomData>().room),
              ],
            ),
          ),
        if (context.watch<RoomData>().isBusy)
          Center(
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
