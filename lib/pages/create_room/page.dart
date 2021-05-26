import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/data_field.dart';
import 'data.dart';
import '../../constants.dart';

class CreateRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Создание помещения"),
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
                    hint: "Имя",
                    errorText: context.watch<CreateRoomData>().nameError,
                    onChanged: (text) {
                      context.read<CreateRoomData>().name = text;
                    }),
                DataField(
                    hint: "Код",
                    isPassword: true,
                    errorText: context.watch<CreateRoomData>().codeError,
                    onChanged: (text) {
                      context.read<CreateRoomData>().code = text;
                    }),
                InkWell(
                  onTap: () {
                    context.read<CreateRoomData>().create(context);
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
                        if (!context.watch<CreateRoomData>().isBusy)
                          Text(
                            "Создать",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (context.watch<CreateRoomData>().isBusy)
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
