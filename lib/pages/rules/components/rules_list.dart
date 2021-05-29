import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../data.dart';
import 'rule_card.dart';

class RulesList extends StatefulWidget {
  final int deviceID;

  RulesList(this.deviceID);

  @override
  _RulesListState createState() => _RulesListState();
}

class _RulesListState extends State<RulesList> {
  @override
  void initState() {
    super.initState();
    context.read<RulesData>().currentContext = context;
    context.read<RulesData>().refresh(context, widget.deviceID);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: secondaryColor,
      onRefresh: () async {
        context.read<RulesData>().refresh(context, widget.deviceID);
      },
      child: Stack(
        children: [
          ListView.builder(
              itemCount: context.read<RulesData>().rules.length,
              itemBuilder: (context, i) {
                return RuleCard(context.read<RulesData>().rules[i]);
              }),
          if (context.watch<RulesData>().isBusy)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (context.watch<RulesData>().isNotFound)
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
