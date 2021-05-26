import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mclimate/models/change.dart';

import '../../../constants.dart';

class HistoryCard extends StatelessWidget {
  final Change change;

  HistoryCard(this.change);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      margin: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      padding: EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
      ),
      child: Column(
        children: [
          Text(
            "${change.message} ${DateFormat("dd.MM.yyyy").format(change.date)} в ${DateFormat.Hm().format(change.date)}",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
