import 'package:flutter/material.dart';
import 'package:mclimate/models/rule.dart';
import '../data.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class RuleCard extends StatelessWidget {
  final Rule rule;

  RuleCard(this.rule);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        context.read<RulesData>().delete(rule.deviceID, rule.id);
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
            Icon(Icons.receipt_long_outlined,
                color: Colors.blueAccent, size: 100),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rule.status,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: defaultPadding),
                  Text(
                    "Отклонение: ${rule.offset}",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
