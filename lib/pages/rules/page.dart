import 'package:flutter/material.dart';
import 'package:mclimate/pages/create_rule/data.dart';
import 'package:mclimate/pages/create_rule/page.dart';
import 'package:mclimate/pages/rooms/page.dart';
import 'package:mclimate/pages/rules/data.dart';
import '../../constants.dart';
import 'components/rules_list.dart';
import 'package:provider/provider.dart';

class RulesPage extends StatelessWidget {
  final int deviceID;

  RulesPage(this.deviceID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Text("Правила"),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                context.read<CreateRuleData>().clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateRulePage(deviceID))).then(
                    (value) =>
                        context.read<RulesData>().refresh(context, deviceID));
              },
            ),
          ],
        ),
      ),
      body: RulesList(deviceID),
    );
  }
}
