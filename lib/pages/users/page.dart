import 'package:flutter/material.dart';
import 'package:mclimate/pages/create_room/data.dart';
import 'package:mclimate/pages/create_room/page.dart';
import '../../constants.dart';
import 'package:provider/provider.dart';
import 'components/users_list.dart';
import 'data.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Text("Пользователи"),
            Spacer(),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                context.read<CreateRoomData>().clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateRoomPage())).then(
                    (value) => context.read<UsersData>().refresh(context));
              },
            ),
          ],
        ),
      ),
      body: UsersList(),
    );
  }
}
