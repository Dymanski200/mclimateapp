import 'package:flutter/material.dart';
import 'package:mclimate/models/tokens.dart';
import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/pages/loading/page.dart';
import 'package:mclimate/pages/rooms/page.dart';
import 'package:mclimate/pages/users/page.dart';
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
        title: Row(
          children: [
            Text("Меню"),
            Spacer(),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                storage.setTokens(new Tokens("", ""));
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
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
                MenuItem(
                  name: "Пользователи",
                  icon: Icons.person,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UsersPage()));
                  },
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
                      vertical: defaultPadding / 2,
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
