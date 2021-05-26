import 'package:flutter/material.dart';
import 'package:mclimate/models/profile.dart';
import 'package:mclimate/pages/profiles/data.dart';
import 'package:provider/provider.dart';
import 'components/data_field.dart';
import 'data.dart';
import '../../constants.dart';

class UrlPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Введите адрес сервера"),
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
                    hint: "Адрес сервера",
                    errorText: null,
                    onChanged: (text) {
                      context.read<UrlData>().url = text;
                    }),
                InkWell(
                  onTap: () {
                    context.read<UrlData>().setUrlMethod(context);
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
                    child: Text(
                      "Ок",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
