import 'package:flutter/material.dart';
import 'package:mclimate/models/tokens.dart';
import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/pages/loading/page.dart';
import 'package:mclimate/pages/rooms/page.dart';
import 'components/menu_item.dart';
import '../../constants.dart';
import '../../services/storage.dart' as storage;

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("Меню"),
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MenuItem(
                    name: "Помещения",
                    icon: Icons.sensor_door_rounded,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RoomsPage()));
                    }),
                InkWell(
                  onTap: () {
                    storage.setTokens(new Tokens("", ""));
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding / 6,
                    ),
                    padding: EdgeInsets.all(defaultPadding / 3),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius)),
                    ),
                    child: Text(
                      "Выйти",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    storage.setUrl("");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoadingPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding / 6,
                    ),
                    padding: EdgeInsets.all(defaultPadding / 3),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius:
                          BorderRadius.all(Radius.circular(defaultRadius)),
                    ),
                    child: Text(
                      "Сменить сервер",
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
