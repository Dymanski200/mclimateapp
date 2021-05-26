import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/data_field.dart';
import 'data.dart';
import '../../constants.dart';

class CreateRulePage extends StatelessWidget {
  final int deviceID;
  CreateRulePage(this.deviceID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Создание правила"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            margin: EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DataField(
                    hint: "Отклонение",
                    errorText: context.watch<CreateRuleData>().offsetError,
                    onChanged: (text) {
                      context.read<CreateRuleData>().offset =
                          double.parse(text);
                    }),
                DataField(
                    hint: "Команда",
                    errorText: context.watch<CreateRuleData>().commandError,
                    onChanged: (text) {
                      context.read<CreateRuleData>().command = text;
                    }),
                DataField(
                    hint: "Статус",
                    errorText: context.watch<CreateRuleData>().statusError,
                    onChanged: (text) {
                      context.read<CreateRuleData>().status = text;
                    }),
                InkWell(
                  onTap: () {
                    context.read<CreateRuleData>().temperature =
                        !context.read<CreateRuleData>().temperature;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: defaultPadding / 2),
                    padding: EdgeInsets.all(defaultPadding / 3),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius)),
                    ),
                    child: Stack(
                      children: [
                        if (!context.watch<CreateRuleData>().temperature)
                          Text(
                            "Влажность",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (context.watch<CreateRuleData>().temperature)
                          Text(
                            "Температура",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<CreateRuleData>().create(context, deviceID);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: defaultPadding / 2),
                    padding: EdgeInsets.all(defaultPadding / 3),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius)),
                    ),
                    child: Stack(
                      children: [
                        if (!context.watch<CreateRuleData>().isBusy)
                          Text(
                            "Создать",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (context.watch<CreateRuleData>().isBusy)
                          SizedBox(
                              width: 21,
                              height: 21,
                              child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
