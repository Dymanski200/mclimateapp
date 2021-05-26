import 'package:flutter/material.dart';
import 'package:mclimate/constants.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import 'history_card.dart';

class HistoryList extends StatefulWidget {
  final int roomID;
  HistoryList(this.roomID);
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  void initState() {
    super.initState();
    context.read<ChangesData>().refresh(context, widget.roomID);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: secondaryColor,
      onRefresh: () async {
        context.read<ChangesData>().refresh(context, widget.roomID);
      },
      child: Stack(
        children: [
          if (context.watch<ChangesData>().isBusy)
            Center(
              child: CircularProgressIndicator(),
            ),
          ListView.builder(
              itemCount: context.read<ChangesData>().changes.length,
              itemBuilder: (context, i) {
                return HistoryCard(context.read<ChangesData>().changes[i]);
              }),
          if (context.watch<ChangesData>().isNotFound)
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
