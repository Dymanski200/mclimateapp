import 'package:flutter/material.dart';
import 'package:mclimate/models/profile.dart';
import 'package:mclimate/pages/profiles/data.dart';
import 'package:provider/provider.dart';
import 'components/data_field.dart';
import 'data.dart';
import '../../constants.dart';

class CodePage extends StatelessWidget {
  final int roomID;
  final Profile profile;
  CodePage(this.roomID, this.profile);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Введите код доступа"),
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
                    isPassword: true,
                    hint: "Код",
                    errorText: context.watch<CodeData>().codeError,
                    onChanged: (text) {
                      context.read<CodeData>().code = text;
                    }),
                InkWell(
                  onTap: () {
                    context
                        .read<CodeData>()
                        .setClimate(context, roomID, profile);
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
                        if (!context.watch<CodeData>().isBusy)
                          Text(
                            "Войти",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (context.watch<CodeData>().isBusy)
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
